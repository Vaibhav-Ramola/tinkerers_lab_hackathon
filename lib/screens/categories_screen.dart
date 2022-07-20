import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:tinkerlab_app/models/item_model.dart';
import 'package:tinkerlab_app/providers/item_provider.dart';
import 'package:tinkerlab_app/widgets/inventory_tile_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool isLiked = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final String? email = auth.currentUser?.email;
    final bool showAddItemButton = email == "ep20btech11025@iith.ac.in";
    var inventoryItemsList =
        Provider.of<ItemProvider>(context).inventoryItemsList;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "Tinkerer's Inventory",
        ),
        actions: [
          IconButton(
            onPressed: showAddItemButton
                ? () {
                    Navigator.of(context).pushNamed("add_new_item");
                  }
                : null,
            icon: const Icon(
              Icons.add_rounded,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: showAddItemButton
                ? () {
                    Navigator.of(context).pushNamed(
                        "delete_screen"); // add delete screen route here
                  }
                : null,
            icon: const Icon(
              Icons.delete_forever,
              color: Colors.red,
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(),
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  "Categories",
                ),
              ),
            ),
            ListTile(
              title: Text("Microcontrollers"),
              onTap: () {},
            ),
            ListTile(
              title: Text("ICs"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Sensors"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Breadboard"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Wires"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Meters"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Misc."),
              onTap: () {},
            ),
            ListTile(
              title: const Text("logout"),
              onTap: () {
                auth.signOut();
              },
            )
          ],
        ),
      ),
      body: FutureBuilder(
          future:
              Provider.of<ItemProvider>(context).fetchAndSetInventoryItems(),
          builder: (context, snapshot) {
            // print(snapshot);
            if (!snapshot.hasData) {
              return const SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            print(snapshot.data);
            inventoryItemsList = snapshot.data as List<Item>;
            return Container(
              padding: const EdgeInsets.only(
                right: 24,
                left: 24,
                top: 8,
              ),
              child: GridView.builder(
                itemCount: inventoryItemsList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                ),
                itemBuilder: (context, index) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return InventoryTile(
                        constraints,
                        inventoryItemsList[index],
                      );
                    },
                  );
                },
              ),
            );
          }),
    );
  }
}
