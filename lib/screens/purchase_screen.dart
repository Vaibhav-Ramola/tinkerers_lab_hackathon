import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinkerlab_app/models/cart_item_model.dart';
import 'package:tinkerlab_app/providers/item_provider.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({Key? key}) : super(key: key);

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  List<CartItem> cartList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cartList = Provider.of<ItemProvider>(context).cartItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Issue component"),
      ),
      body: FutureBuilder(
          future: Provider.of<ItemProvider>(
            context,
            listen: false,
          ).fetchAndSetCartItems(),
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
            return ListView.builder(
              itemCount: cartList.length,
              itemBuilder: ((context, index) {
                return Dismissible(
                  onDismissed: (_) {
                    setState(() {
                      cartList.removeAt(index);
                    });
                  }, // add remove from cart code here.
                  key: UniqueKey(),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Image.network(cartList[index].imageUrl),
                    ),
                    title: Text(cartList[index].name),
                  ),
                );
              }),
            );
          }),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.send),
          onPressed: () {
            Provider.of<ItemProvider>(context, listen: false)
                .sendRequest(cartList);
          }),
    );
  }
}
