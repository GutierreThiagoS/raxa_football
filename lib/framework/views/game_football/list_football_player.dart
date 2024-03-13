import 'package:flutter/material.dart';
import 'package:football/controller/include_player_team_controller.dart';
import 'package:football/controller/player_in_team_controller.dart';
import 'package:football/data/repository/player_in_team_repository_impl.dart';
import 'package:football/data/repository/player_soccer_repository_impl.dart';
import 'package:football/domain/models_entity/game.dart';
import 'package:football/domain/models_entity/player_in_team.dart';
import 'package:football/framework/views/game_football/item_football_player.dart';
import 'package:football/framework/views/dialog/dialog_add_player_in_team.dart';

class ListFootballPlayer extends StatefulWidget {
  final String title;
  final List<PlayerInTeam> players;
  final int teamId;
  final Game game;
  final Function(List<PlayerInTeam>) refresh;
  final Function(PlayerInTeam) removerPlayer;
  final Function(PlayerInTeam) playerGol;

  const ListFootballPlayer({
    super.key,
    required this.title,
    required this.players,
    required this.teamId,
    required this.game,
    required this.refresh,
    required this.removerPlayer,
    required this.playerGol
  });

  @override
  State<ListFootballPlayer> createState() => _ListFootballPlayerState();
}

class _ListFootballPlayerState extends State<ListFootballPlayer> {
  final controller = PlayerInTeamController(PlayerInTeamRepositoryImpl());
  final controllerPlayer = IncludePlayerTeamController(PlayerSoccerRepositoryImpl());

  final isNewGamerPlayer = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Card(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width / 2,
            child: Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        ListView.separated(
            separatorBuilder: (_, __) => const Divider(),
            itemCount: widget.players.length,
            shrinkWrap: true,
            itemBuilder: (_, i) {
              return ItemFootballPlayer(
                player: widget.players[i],
                game: widget.game,
                removerPlayer: () {
                  controller.removerPlayerInTeam(widget.players[i]).then((removePlayer) {
                    if (removePlayer != null) {
                      widget.removerPlayer(removePlayer);
                    }
                  });
                },
                marcarGol: () {
                  widget.playerGol(widget.players[i]);
                },
              );
            }
        ),
        widget.players.length < 5
            ? TextButton(
            onPressed: () {
              controllerPlayer.getAllPlayersNotTeam().then((list) {
                showDialogAddPlayerInTeam(
                    context,
                    list,
                    5 - widget.players.length,
                    widget.teamId,
                    (list) {
                      controller.updateAllPlayerSoccer(list, widget.teamId)
                          .then((value) => widget.refresh(value));
                    }
                );
              });
            },
            child: const Text("Adicionar")
        )
            :Container()
      ],
    );
  }
}
