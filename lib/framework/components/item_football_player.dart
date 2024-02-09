import 'package:flutter/material.dart';

class ItemFootballPlayer extends StatefulWidget {
  final String title;
  const ItemFootballPlayer({super.key, required this.title});

  @override
  State<ItemFootballPlayer> createState() => _ItemFootballPlayerState();
}

class _ItemFootballPlayerState extends State<ItemFootballPlayer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
        child: Text(widget.title)
    );
  }
}
