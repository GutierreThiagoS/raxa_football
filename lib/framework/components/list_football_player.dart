import 'package:flutter/material.dart';
import 'package:football/framework/components/item_football_player.dart';

class ListFootballPlayer extends StatefulWidget {
  final String title;
  final List<String> players;
  const ListFootballPlayer({super.key, required this.title, required this.players});

  @override
  State<ListFootballPlayer> createState() => _ListFootballPlayerState();
}

class _ListFootballPlayerState extends State<ListFootballPlayer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Card(
          child: Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width/2,
            child: Text(
                widget.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            ),
          ),
        ),
        ListView.separated(
          separatorBuilder: (_, __) => const Divider(),
          itemCount: widget.players.length < 5 ? widget.players.length + 1 : widget.players.length,
          shrinkWrap: true,
          itemBuilder: (_, i) {
            if (i < widget.players.length) {
              return ItemFootballPlayer(title: widget.players[i]);
            } else {
              return TextButton(
                  onPressed: () {

                  },
                  child: Text("Adicionar")
              );
            }
          }
      )],
    );
  }
}
