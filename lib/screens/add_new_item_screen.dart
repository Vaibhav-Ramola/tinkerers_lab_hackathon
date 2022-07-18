import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinkerlab_app/models/item_model.dart';
import 'package:tinkerlab_app/providers/item_provider.dart';

class AddNewItemScreen extends StatefulWidget {
  const AddNewItemScreen({Key? key}) : super(key: key);

  @override
  State<AddNewItemScreen> createState() => _AddNewItemScreenState();
}

class _AddNewItemScreenState extends State<AddNewItemScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedItem = "microcontrollers";
  final List<String> items = [
    "microcontrollers",
    "ICs",
    "sensors",
    "breadboard",
    "wires",
    "clipers",
    "meters",
    "misc.",
  ];
  String? name;
  String? description;
  String? imageUrl;
  String? category;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Add item",
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    style: BorderStyle.solid,
                    color: Colors.blue,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      12,
                    ),
                  ),
                ),
                height: 200,
                width: double.infinity * 0.75,
                child: Placeholder(),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onSaved: (newValue) {
                        imageUrl = newValue;
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Please enter a valid url";
                        }
                        if (value.trim() == '') {
                          return "Url is empty";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text("Image url"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onSaved: (newValue) {
                        name = newValue;
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Please enter a valid component name";
                        }
                        if (value.trim() == '') {
                          return "no component name given";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text("Component name"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onSaved: (newValue) => description = newValue,
                      validator: (value) {
                        if (value == null) {
                          return "Please enter a valid description";
                        }
                        if (value.trim() == '') {
                          return "description is empty is empty";
                        }
                        return null;
                      },
                      minLines: 2,
                      maxLines: 7,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        label: Text("Description"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: DropdownButtonFormField(
                  validator: (value) {
                    if (value == null) {
                      return "Please enter a valid description";
                    }
                    if ((value as String).trim() == '') {
                      return "description is empty is empty";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text("Category"),
                    border: OutlineInputBorder(),
                  ),
                  value: selectedItem,
                  items: items
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                  onChanged: (item) => setState(
                    () {
                      selectedItem = item as String?;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                // height: double.infinity,
                child: Center(
                  child: ElevatedButton(
                    child: const Text("Add ! "),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        category = selectedItem;
                      }
                      Provider.of<ItemProvider>(
                        context,
                        listen: false,
                      )
                          .addItemToInventory(
                            Item(
                              category: category!,
                              description: description!,
                              imageUrl: imageUrl!,
                              name: name!,
                            ),
                          )
                          .then(
                            (value) => Navigator.of(context).pop(),
                          );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
