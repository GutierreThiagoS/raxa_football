import 'package:flutter/material.dart';
import 'package:football/controller/game_team_controller.dart';
import 'package:football/data/repository/game_repository_impl.dart';
import 'package:football/framework/views/game_football/list_football_player.dart';

class GameTeamsView extends StatefulWidget {
  const GameTeamsView({super.key});

  @override
  State<GameTeamsView> createState() => _GameTeamsViewState();
}

class _GameTeamsViewState extends State<GameTeamsView> {
  final controller = GameTeamsController(GameRepositoryImpl());

  @override
  void initState() {
    super.initState();
    controller.getGameData();
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
            return Column(
              children: [
                Container(
                  color: Colors.black12,
                  padding:
                      EdgeInsets.only(top: 30, bottom: 20, left: 10, right: 10),
                  child: Row(
                    children: [
                      Expanded(child: Image.asset("assets/camisa_ce.png")),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
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
                            ElevatedButton(
                                onPressed: () {
                                  controller.initGame(game.game).then((value) {
                                    controller.startTimer();
                                  });
                                },
                                child: Icon(Icons.play_arrow))
                          ],
                        ),
                      ),
                      Expanded(child: Image.asset("assets/sem_camisa.png")),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListFootballPlayer(
                        game: game.game,
                        title: game.teamAndPlayers1.team.name,
                        players: game.teamAndPlayers1.players,
                        teamId: game.teamAndPlayers1.team.id ?? -1,
                        refresh: (list) {
                          controller.gameAndTeams.value?.teamAndPlayers1.players
                              .addAll(list);
                          controller.gameAndTeams.notifyListeners();
                        },
                        removerPlayer: (player) {
                          controller.gameAndTeams.value?.teamAndPlayers1.players
                              .remove(player);
                          controller.gameAndTeams.notifyListeners();
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
                      child: ListFootballPlayer(
                        title: game.teamAndPlayers2.team.name,
                        players: game.teamAndPlayers2.players,
                        game: game.game,
                        teamId: game.teamAndPlayers2.team.id ?? -1,
                        refresh: (list) {
                          controller.gameAndTeams.value?.teamAndPlayers2.players
                              .addAll(list);
                          controller.gameAndTeams.notifyListeners();
                        },
                        removerPlayer: (player) {
                          controller.gameAndTeams.value?.teamAndPlayers2.players
                              .remove(player);
                          controller.gameAndTeams.notifyListeners();
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
                )
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
