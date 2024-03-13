import 'package:flutter/material.dart';
import 'package:football/controller/game_team_controller.dart';
import 'package:football/domain/models_entity/game.dart';
import 'package:football/framework/utils/functions.dart';

class ItemGameViewHolder extends StatelessWidget {
  final Game game;
  final GameTeamsController controller;
  const ItemGameViewHolder({super.key, required this.game, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: controller.getTeamsInGame(game.id??1),
          builder: (context, snapshot) {
            if (snapshot.data?.isNotEmpty?? false) {
              final team1 = snapshot.data!.firstWhere((e) => e.team.id == game.idTeam1);
              final team2 = snapshot.data!.firstWhere((e) => e.team.id == game.idTeam2);
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Image.asset(team1.team.image)
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${sumByGoal(team1)}",
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
                                "${sumByGoal(team2)}",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            child: Image.asset(team2.team.image)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          game.dateTimeInit.isNotEmpty
                          ? "Inicio ${game.dateTimeInit}"
                          : "",
                          style: TextStyle(
                              fontSize: 12),
                        ),
                        SizedBox(width: 20),
                        Text(
                          game.dateTimeFinish.isNotEmpty
                          ? "Fim ${game.dateTimeFinish}"
                              : "",
                          style: TextStyle(
                              fontSize: 12),
                        ),
                      ])
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
      ),
    );
  }
}
