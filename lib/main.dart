import 'package:flutter/material.dart';
import 'package:tinkerlab_app/screens/add_new_item_screen.dart';
import 'package:tinkerlab_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      routes: {
        "add_new_item" :(context) => const AddNewItemScreen(),
      },
    );
  }
}
