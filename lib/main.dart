import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinkerlab_app/providers/item_provider.dart';
import 'package:tinkerlab_app/screens/add_new_item_screen.dart';
import 'package:tinkerlab_app/screens/auth_screen.dart';
import 'package:tinkerlab_app/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => ItemProvider()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AuthScreen(),
        routes: {
          "home_screen": (context) => const HomeScreen(),
          "add_new_item": (context) => const AddNewItemScreen(),
          "auth_screen": (context) => const AuthScreen(),
        },
      ),
    );
  }
}
