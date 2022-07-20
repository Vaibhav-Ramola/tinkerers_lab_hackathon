import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinkerlab_app/providers/item_provider.dart';

import '../models/item_model.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late List<Item> favourites;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourites"),
      ),
      body: FutureBuilder(
        future: Provider.of<ItemProvider>(context).fetchAndSetFavourites(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          favourites = snapshot.data as List<Item>;
          return ListView.builder(
            itemBuilder: ((context, index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Image.network(favourites[index].imageUrl),
                ),
                title: Text(favourites[index].name),
                subtitle: Text(favourites[index].category),
              );
            }),
            itemCount: favourites.length,
          );
        },
      ),
    );
  }
}
