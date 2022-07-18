import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tinkerlab_app/models/item_model.dart';

class ItemProvider with ChangeNotifier{
  List<Item> _inventoryItemsList = [];

  List<Item> get inventoryItemsList => [..._inventoryItemsList];

  Future<void> fetchAndSetInventoryItems() async {
    _inventoryItemsList.clear();
    final url = Uri.parse(
        "https://tinkererslab-e8d3e-default-rtdb.asia-southeast1.firebasedatabase.app/inventory_items");
    try {} catch (e) {}
  }

  Future<void> addItemToInventory(Item item) async {
    final url = Uri.parse(
        "https://tinkererslab-e8d3e-default-rtdb.asia-southeast1.firebasedatabase.app/inventory_items");
    try {
      http
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
          .then((value) {
        _inventoryItemsList.add(item);
        
      });
    } catch (e) {}
  }
}
