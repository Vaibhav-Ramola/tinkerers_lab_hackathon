import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class InventoryTile extends StatefulWidget {
  final constraints;

  const InventoryTile(this.constraints, {Key? key}) : super(key: key);

  @override
  State<InventoryTile> createState() => _InventoryTileState();
}

class _InventoryTileState extends State<InventoryTile> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 50,
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      decoration: BoxDecoration(
        border: Border.all(
          style: BorderStyle.solid,
          color: Colors.orange,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: ListView(
        children: [
          Expanded(
            child: GestureDetector(
              onDoubleTap: (() {
                setState(() {
                  isLiked = !isLiked;
                });
              }),
              child: Stack(
                children: [
                  Positioned(
                    right: 10,
                    top: 10,
                    child: LikeButton(
                      size: 40,
                      isLiked: isLiked,
                    ),
                  ),
                  Expanded(
                    child: Card(
                      elevation: 5,
                      child: Container(
                        height: widget.constraints.maxHeight * 0.6,
                        width: double.infinity,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Container(
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
                    topLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: widget.constraints.minHeight,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
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
