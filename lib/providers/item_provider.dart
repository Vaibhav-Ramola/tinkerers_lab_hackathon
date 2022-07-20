import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tinkerlab_app/models/cart_item_model.dart';
import 'dart:convert';

import 'package:tinkerlab_app/models/item_model.dart';

class ItemProvider with ChangeNotifier {
  List<Item> _inventoryItemsList = [];
  List<CartItem> _cartItemList = [];
  Set<String> _favourites = {};
  final auth = FirebaseAuth.instance;

  List<Item> get inventoryItemsList => [..._inventoryItemsList];
  // Map<String, bool> _favourites = {};
  List<CartItem> get cartItems => [..._cartItemList];
  Future<List<Item>> fetchAndSetInventoryItems() async {
    _inventoryItemsList.clear();
    String? email = auth.currentUser?.email;
    if (email != null) {
      int index = email.indexOf("@");
      email = email.substring(0, index);
    }
    // print(email);
    final url = Uri.parse(
      "https://tinkererslab-e8d3e-default-rtdb.asia-southeast1.firebasedatabase.app/inventory_items.json",
    );
    final favUrl = Uri.parse(
      "https://tinkererslab-e8d3e-default-rtdb.asia-southeast1.firebasedatabase.app/$email/favourites.json",
    );

    try {
      final response = await http.get(url);
      final favResponse = await http.get(favUrl);
      dynamic favData;
      // print("fav response : ${favResponse.body}");

      favData = json.decode(favResponse.body);
      if (favData != null) {
        favData = favData as Map<String, dynamic>;
      }

      // print(response.body.runtimeType);
      dynamic data =
          json.decode(response.body.toString()) as Map<String, dynamic>;
      // print(data);
      if (data != null) {
        data.forEach(
          (key, value) {
            bool like = false;
            if (favData != null) {
              if (favData[key] == true) {
                like = true;
              }
            }
            _inventoryItemsList.add(
              Item(
                category: value["category"] as String,
                description: value["description"] as String,
                imageUrl: value["imageUrl"] as String,
                name: value["name"] as String,
                id: key,
                isFavourite: like, // change is favourite here
              ),
            );
          },
        );
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
    // ignore: null_argument_to_non_null_type
    return Future.value([..._inventoryItemsList]);
  }

  Future<void> addItemToInventory(Item item) async {
    final url = Uri.parse(
        "https://tinkererslab-e8d3e-default-rtdb.asia-southeast1.firebasedatabase.app/inventory_items.json");
    try {
      await http
          .post(
        url,
        body: json.encode(
          {
            "name": item.name,
            "category": item.category,
            "description": item.description,
            "imageUrl": item.imageUrl,
            "id": item.id,
            "isFav": item.isFavourite,
          },
        ),
      )
          .then(
        (value) {
          // _inventoryItemsList.add(item);
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<bool?> toggleItemLike(bool isLiked, String id) async {
    String? email = auth.currentUser?.email;
    int index = email!.indexOf('@');
    email = email.substring(0, index);
    // print(email);
    final url = Uri.parse(
        "https://tinkererslab-e8d3e-default-rtdb.asia-southeast1.firebasedatabase.app/$email/favourites.json");

    await http.patch(
      url,
      body: json.encode(
        {
          id: isLiked.toString(),
        },
      ),
    );
  }

  Future<void> addToCart(Item item) async {
    String? email = auth.currentUser?.email;
    int index = email!.indexOf('@');
    email = email.substring(0, index);
    final url = Uri.parse(
        "https://tinkererslab-e8d3e-default-rtdb.asia-southeast1.firebasedatabase.app/$email/cart.json");
    try {
      await http.post(
        url,
        body: json.encode(
          {
            "id": item.id,
            "name": item.name,
            "imageUrl": item.imageUrl,
          },
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<List<CartItem>> fetchAndSetCartItems() async {
    _cartItemList.clear();
    String? email = auth.currentUser?.email;
    if (email != null) {
      int index = email.indexOf("@");
      email = email.substring(0, index);
    }
    final url = Uri.parse(
        "https://tinkererslab-e8d3e-default-rtdb.asia-southeast1.firebasedatabase.app/$email/cart.json");

    try {
      final response = await http.get(url);
      dynamic data =
          json.decode(response.body.toString()) as Map<String, dynamic>;
      print(data);
      data.forEach(
        (key, value) {
          _cartItemList.add(
            CartItem(
              id: value["id"],
              imageUrl: value["imageUrl"],
              name: value["name"],
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return Future.value([..._cartItemList]);
  }

  Future<void> deleteItemFromInventory(String id) async {
    final url = Uri.parse(
      "https://tinkererslab-e8d3e-default-rtdb.asia-southeast1.firebasedatabase.app/inventory_items/$id.json",
    );
    _inventoryItemsList.removeWhere((element) => element.id == id);
    try {
      await http.delete(url);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
