import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tinkerlab_app/models/item_model.dart';

class ItemProvider with ChangeNotifier {
  List<Item> _inventoryItemsList = [];

  List<Item> get inventoryItemsList => [..._inventoryItemsList];

  Future<List<Item>> fetchAndSetInventoryItems() async {
    _inventoryItemsList.clear();
    final url = Uri.parse(
      "https://tinkererslab-e8d3e-default-rtdb.asia-southeast1.firebasedatabase.app/inventory_items.json",
    );

    try {
      final response = await http.get(url);
      // print(response.body.runtimeType);
      dynamic data =
          json.decode(response.body.toString()) as Map<String, dynamic>;
      data.forEach(
        (key, value) {
          _inventoryItemsList.add(
            Item(
              category: value["category"] as String,
              description: value["description"] as String,
              imageUrl: value["imageUrl"] as String,
              name: value["name"] as String,
            ),
          );
        },
      );
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
          },
        ),
      )
          .then(
        (value) {
          _inventoryItemsList.add(item);
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
