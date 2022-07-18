import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:tinkerlab_app/providers/item_provider.dart';
import 'package:tinkerlab_app/widgets/inventory_tile_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    final inventoryItemsList =
        Provider.of<ItemProvider>(context).inventoryItemsList;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "Tinkerer's Inventory",
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("add_new_item");
            },
            icon: const Icon(
              Icons.add_rounded,
              color: Colors.white,
            ),
          ),
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
              title: Text("logout"),
              onTap: () {},
            )
          ],
        ),
      ),
      body: FutureBuilder(
          future:
              Provider.of<ItemProvider>(context).fetchAndSetInventoryItems(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.none) {
              return const SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
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
