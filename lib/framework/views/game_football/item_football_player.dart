import 'package:flutter/material.dart';
import 'package:football/domain/models_entity/game.dart';
import 'package:football/domain/models_entity/player_soccer.dart';
import 'package:football/framework/views/dialog/dialog_confirm.dart';

class ItemFootballPlayer extends StatefulWidget {
  final PlayerSoccer player;
  final Game game;
  final Function() removerPlayer;
  final Function() marcarGol;
  const ItemFootballPlayer({
    super.key,
    required this.player,
    required this.game,
    required this.removerPlayer,
    required this.marcarGol
  });

  @override
  State<ItemFootballPlayer> createState() => _ItemFootballPlayerState();
}

class _ItemFootballPlayerState extends State<ItemFootballPlayer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.player.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),
                    ),
                    const SizedBox(height: 15),
                    widget.game.initGame ? Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              widget.marcarGol();
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            },
                            child: const Row(children: [
                              Text("Gol"),
                              SizedBox(width: 8),
                              Icon(Icons.sports_soccer)
                            ])
                        ),
                      ],
                    )
                    : Row(children: [
                      ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                          child: const Row(children: [
                            Text("Editar"),
                            SizedBox(width: 8),
                            Icon(Icons.edit)
                          ])
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                          onPressed: () {
                            showDialogConfirm(
                                context,
                                "Atenção",
                                "Deseja Realmente retirar o ${widget.player.name} da partida?",
                                    () {
                                      widget.removerPlayer();
                                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                    }
                            );
                          },
                          child: const Row(children: [
                            Text("Remover"),
                            SizedBox(width: 8),
                            Icon(Icons.delete)
                          ])
                      ),
                    ])
                ])
            )
        );
      },
      child: Container(
        padding: EdgeInsets.all(5),
          child: Text(widget.player.name)
      ),
    );
  }
}
