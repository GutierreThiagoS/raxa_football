import 'package:flutter/material.dart';
import 'package:football/controller/game_team_controller.dart';
import 'package:football/domain/models_entity/game.dart';

class ItemGameViewHolder extends StatelessWidget {
  final Game game;
  final GameTeamsController controller;
  const ItemGameViewHolder({super.key, required this.game, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: controller.getTeams(),
          builder: (context, snapshot) {
            if (snapshot.data?.isNotEmpty?? false) {
              final team1 = snapshot.data!.firstWhere((e) => e.id == game.idTeam1);
              final team2 = snapshot.data!.firstWhere((e) => e.id == game.idTeam2);
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Image.asset(team1.image)
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${team1.gol}",
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
                                "${team2.gol}",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            child: Image.asset(team2.image)),
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
