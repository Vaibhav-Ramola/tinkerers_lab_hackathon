import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:tinkerlab_app/providers/item_provider.dart';
import 'package:tinkerlab_app/screens/auth_screen.dart';
import 'package:tinkerlab_app/screens/categories_screen.dart';
import 'package:tinkerlab_app/screens/favourites_screen.dart';
import 'package:tinkerlab_app/screens/purchase_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> screens = [
    const FavouriteScreen(),
    const CategoriesScreen(),
    const PurchaseScreen(),
  ];
  int screenIndex = 1;
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[screenIndex], //screens[screenIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: ((value) {
          setState(() {
            screenIndex = value;
          });
        }),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: screenIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_outline_rounded,
            ),
            label: "favourites",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.inventory_2_rounded,
            ),
            label: "inventory",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_basket_rounded,
            ),
            label: "issue",
          ),
        ],
      ),
    );
  }
}
