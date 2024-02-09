
import 'package:flutter/material.dart';

class ItemMenuFirst extends StatefulWidget {
  final String title;
  final String subTitle;
  const ItemMenuFirst({super.key, required this.title, required this.subTitle});

  @override
  State<ItemMenuFirst> createState() => _ItemMenuFirstState();
}

class _ItemMenuFirstState extends State<ItemMenuFirst> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Card(child: Row(
        children: [
          Column(
            children: [
              Text(widget.title),
              Text(widget.subTitle),
            ],
          ),

        ],
      )),
      onTap: () {
        // Update the state of the app.
        // ...
      },
    );
  }
}
