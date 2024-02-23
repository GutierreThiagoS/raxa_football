import 'dart:math';

import 'package:flutter/material.dart';
import 'package:football/controller/game_team_controller.dart';
import 'package:football/controller/include_player_team_controller.dart';
import 'package:football/data/repository/game_repository_impl.dart';
import 'package:football/data/repository/player_in_team_repository_impl.dart';
import 'package:football/data/repository/player_soccer_repository_impl.dart';
import 'package:football/framework/views/dialog/dialog_select_new_game.dart';
import 'package:football/framework/views/game_football/list_football_player.dart';

class GameTeamsView extends StatefulWidget {
  const GameTeamsView({super.key});

  @override
  State<GameTeamsView> createState() => _GameTeamsViewState();
}

class _GameTeamsViewState extends State<GameTeamsView> {
  final controller = GameTeamsController(GameRepositoryImpl(), PlayerInTeamRepositoryImpl());
  final controllerPlayer = IncludePlayerTeamController(PlayerSoccerRepositoryImpl());

  @override
  void initState() {
    super.initState();
    Future.wait([controller.getGameData()]);
  }

  Future<void> _randomPlayer() async {
    final players = await controllerPlayer.getAllPlayersValue();
    if(players.length >= 10) {
      if (
        controller.gameAndTeams.value != null
          && controller.gameAndTeams.value!.teamAndPlayers1.players.isNotEmpty
          && controller.gameAndTeams.value!.teamAndPlayers2.players.isNotEmpty
      ) {
        for (var player in controller.gameAndTeams.value!.teamAndPlayers1.players) {
          await controllerPlayer.removerPlayerInTeam(player);
        }
        for (var player in controller.gameAndTeams.value!.teamAndPlayers2.players) {
          await controllerPlayer.removerPlayerInTeam(player);
        }
        controller.gameAndTeams.value!.teamAndPlayers1.players = [];
        controller.gameAndTeams.value!.teamAndPlayers2.players = [];
        controller.notifyListeners();
      }
      while((
          (controller.gameAndTeams.value?.teamAndPlayers1.players.length??0) +
              (controller.gameAndTeams.value?.teamAndPlayers2.players.length??0)
      ) < 10) {
        await _randomPlayerTeam(
            (controller.gameAndTeams.value?.teamAndPlayers1.players.length??0) < 5
                ? controller.gameAndTeams.value?.teamAndPlayers1.team.id
                : controller.gameAndTeams.value?.teamAndPlayers2.team.id
        );
      }
    }
  }

  Future<void> _randomPlayerTeam(int? teamId) async {
    if (teamId != null) {

      final playersNotInTeam = await controllerPlayer.getAllPlayersNotTeam();
      final random = Random();
      final i = random.nextInt(playersNotInTeam.length);

      final itemRandom = playersNotInTeam.removeAt(i);

      itemRandom.idTeam = teamId;
      await controllerPlayer.savePlayerSoccer(itemRandom, -1);
      await controller.savePlayerInTeam(itemRandom.id??1, teamId);
      await controller.getGameData();
      controller.notifyListeners();
    }
  }

  @override
  void dispose() {
    controller.timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String dataTimeGame(int time) {
      final duracao = Duration(seconds: time);
      final minutos = duracao.inMinutes.remainder(60);
      final segundosFormatados = duracao.inSeconds.remainder(60);

      return '${minutos.toString().padLeft(2, '0')}:${segundosFormatados.toString().padLeft(2, '0')}';
    }

    return Container(
      child: ValueListenableBuilder(
        valueListenable: controller.gameAndTeams,
        builder: (_, game, __) {
          if (game != null) {
            if(game.game.initGame) {
              controller.initGame(game.game, false).then((value) {
                controller.startTimer();
              });
            }
            return Column(
              children: [
                Container(
                  color: Colors.black12,
                  padding:
                      EdgeInsets.only(top: 30, bottom: 20, left: 10, right: 10),
                  child: Row(
                    children: [
                      Expanded(child: Image.asset(game.teamAndPlayers1.team.image)),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${game.teamAndPlayers1.team.gol}",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  child: Image.asset("assets/bolaf.png",
                                      height: 50),
                                  padding: EdgeInsets.all(8),
                                ),
                                Text(
                                  "${game.teamAndPlayers2.team.gol}",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            ValueListenableBuilder(
                                valueListenable: controller.timerGame,
                                builder: (_, timer, __) {
                                  return Text("${dataTimeGame(timer)}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45));
                                }),
                            game.game.initGame
                                ?  ElevatedButton(
                                onPressed: () {
                                  controller.initGame(game.game, true).then((value) {
                                    controller.startTimer();
                                  });
                                },
                                child: Icon(Icons.pause))
                                : ElevatedButton(
                                onPressed: () {
                                  controller.initGame(game.game, true).then((value) {
                                    controller.startTimer();
                                  });
                                },
                                child: Icon(Icons.play_arrow))
                          ],
                        ),
                      ),
                      Expanded(child: Image.asset(game.teamAndPlayers2.team.image)),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ListFootballPlayer(
                        game: game.game,
                        title: game.teamAndPlayers1.team.name,
                        players: game.teamAndPlayers1.players,
                        teamId: game.teamAndPlayers1.team.id ?? -1,
                        refresh: (list) {
                          controller.gameAndTeams.value?.teamAndPlayers1.players
                              .addAll(list);
                          controller.notifyListeners();
                        },
                        removerPlayer: (player) {
                          controller.gameAndTeams.value?.teamAndPlayers1.players
                              .remove(player);
                          controller.notifyListeners();
                        },
                        playerGol: (player) {
                          controller.registerGolGame(
                              controller
                                  .gameAndTeams.value!.teamAndPlayers1.team,
                              player);
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ListFootballPlayer(
                        title: game.teamAndPlayers2.team.name,
                        players: game.teamAndPlayers2.players,
                        game: game.game,
                        teamId: game.teamAndPlayers2.team.id ?? -1,
                        refresh: (list) {
                          controller.gameAndTeams.value?.teamAndPlayers2.players
                              .addAll(list);
                          controller.notifyListeners();
                        },
                        removerPlayer: (player) {
                          controller.gameAndTeams.value?.teamAndPlayers2.players
                              .remove(player);
                          controller.notifyListeners();
                        },
                        playerGol: (player) {
                          controller.registerGolGame(
                              controller
                                  .gameAndTeams.value!.teamAndPlayers2.team,
                              player);
                        },
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: ElevatedButton(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              game.teamAndPlayers1.players.isEmpty && game.teamAndPlayers2.players.isEmpty
                              ? "Sortear" : "Sortear Novamente"),
                          SizedBox(width: 10,),
                          Icon(Icons.social_distance_rounded)
                        ],
                      ),
                      onPressed: () {
                        _randomPlayer();
                      }
                    ),
                ),
                ElevatedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Nova Partida"),
                        SizedBox(width: 10,),
                        Icon(Icons.autorenew_outlined)
                      ],
                    ),
                    onPressed: () {
                      controller.getTeams().then((list) {
                        dialogSelectNewGame(
                            context,
                            list,
                            (teamCheckboxList) {
                              controller.newGameData(teamCheckboxList);
                            }
                        );
                      });
                    }
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
