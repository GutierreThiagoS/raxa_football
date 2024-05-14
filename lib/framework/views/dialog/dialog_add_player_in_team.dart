
import 'package:flutter/material.dart';
import 'package:football/domain/models/player_soccer_selected_team.dart';
import 'package:football/domain/models_entity/player_soccer.dart';

void showDialogAddPlayerInTeam(
    BuildContext context,
    List<PlayerSoccer> listPlayers,
    int max,
    int teamId,
    Function(List<PlayerSoccer>) result
) {

  ValueNotifier<List<PlayerSoccerSelectedTeam>> players = ValueNotifier(
      listPlayers.map((e) => PlayerSoccerSelectedTeam(player: e, teamId: 0)).toList()
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Adicionar Jogador -> falta $max'),
        scrollable: true,
        content: SizedBox(
            width: MediaQuery.of(context).size.width *  0.9,
            height: MediaQuery.of(context).size.height *  0.4,
            child: ValueListenableBuilder(
              valueListenable: players,
              builder: (_, list, __) {
                print("ValueListenableBuilder $list");
                return ListView.separated(
                      itemBuilder: (_, index) {
                        return Container(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    list[index].player.name,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ),
                                Checkbox(value: list[index].teamId != 0,
                                    onChanged: (value) {
                                      print(value);
                                      if (value != null && value) {
                                        if(players.value.where((element) => element.teamId != 0).toList().length < max) {
                                          list[index].teamId = teamId;
                                          print(list[index]);
                                          players.value[index] = list[index];
                                          players.notifyListeners();
                                        }
                                      } else {
                                        list[index].teamId = 0;
                                        print(list[index]);
                                        players.value[index] = list[index];
                                        players.notifyListeners();
                                      }
                                })
                              ],
                            )
                        );
                      },
                    separatorBuilder: (_, __) => const Divider(),
                    itemCount: list.length,
                    shrinkWrap: true,
                );
              }
            ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              result(
                  players.value.where((element) => element.teamId != 0).toList()
                      .map((e) => e.player).toList()
              );
              Navigator.of(context).pop();
            },
            child: const Text('Adicionar'),
          ),
        ],
      );
    },
  );
}