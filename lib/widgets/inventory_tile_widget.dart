import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../models/item_model.dart';

class InventoryTile extends StatefulWidget {
  final BoxConstraints constraints;
  final Item item;

  const InventoryTile(this.constraints, this.item, {Key? key})
      : super(key: key);

  @override
  State<InventoryTile> createState() => _InventoryTileState();
}

class _InventoryTileState extends State<InventoryTile> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 90,
      // width: 50,
      padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
      decoration: BoxDecoration(
        border: Border.all(
          style: BorderStyle.solid,
          color: Colors.orange,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(right: 8),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                        child: Card(
                          elevation: 5,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                            child: SizedBox(
                              height: widget.constraints.maxHeight * 0.6,
                              width: double.infinity,
                              // color: Colors.orange,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  widget.item.imageUrl,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: LikeButton(
                    size: 25,
                    isLiked: isLiked,
                  ),
                ),
              ],
            ),
          ),
          // const Spacer(),
          Container(
            height: widget.constraints.maxHeight * 0.2,
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              "Item Name",
              style: TextStyle(fontSize: 24),
            ),
          ),
          Row(
            children: [
              const Spacer(),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      border: Border.all(
                        color: Colors.orange,
                        style: BorderStyle.solid,
                        width: 2,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(11),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add_rounded,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
