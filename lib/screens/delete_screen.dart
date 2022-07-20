import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinkerlab_app/models/item_model.dart';

import '../providers/item_provider.dart';

class DeleteScreen extends StatefulWidget {
  const DeleteScreen({Key? key}) : super(key: key);

  @override
  State<DeleteScreen> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  @override
  Widget build(BuildContext context) {
    late var inventoryItemsList;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete Items"),
      ),
      body: FutureBuilder(
        future: Provider.of<ItemProvider>(
          context,
          listen: false,
        ).fetchAndSetInventoryItems(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          inventoryItemsList = snapshot.data as List<Item>;
          return ListView.builder(
            itemCount: inventoryItemsList.length,
            itemBuilder: ((context, index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Image.network(
                    inventoryItemsList[index].imageUrl,
                  ),
                ),
                title: Text(inventoryItemsList[index].name),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Provider.of<ItemProvider>(context, listen: false)
                        .deleteItemFromInventory(inventoryItemsList[index].id);
                  },
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}
