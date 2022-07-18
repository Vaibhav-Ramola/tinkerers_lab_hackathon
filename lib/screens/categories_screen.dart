import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:like_button/like_button.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tinkerer's Inventory",
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_rounded,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(),
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
      body: Container(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          itemCount: 20,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return InventoryTile(constraints);
              },
            );
          },
        ),
      ),
    );
  }
}
