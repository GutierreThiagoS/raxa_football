
import 'package:flutter/material.dart';
import 'package:football/domain/models_entity/player_soccer.dart';

void showDialogAddPlayerInTeam(
    BuildContext context,
    PlayerSoccer player,
    int teamId,
    Function(PlayerSoccer) result
    ) {

  ValueNotifier<PlayerSoccer> playerValue = ValueNotifier(player);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Adicionar Jogador '),
        scrollable: true,
        content: Container(
            width: MediaQuery.of(context).size.width *  0.9,
            height: MediaQuery.of(context).size.height *  0.4,
            /*child:  SingleChildScrollView(
              child: ValueListenableBuilder(
                  valueListenable: playerValue,
                  builder: (_, list, __) {
                    print("ValueListenableBuilder $list");
                    return ListView.separated(
                      itemBuilder: (_, index) {
                        return Container(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    list[index].name,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ),
                                Checkbox(value: list[index].idTeam != -1,
                                    onChanged: (value) {
                                      print(value);
                                      if (value != null && value) {
                                        if(playerValue.value.where((element) => element.idTeam != -1).toList().length < max) {
                                          list[index].idTeam = teamId;
                                          print(list[index]);
                                          playerValue.value[index] = list[index];
                                          playerValue.notifyListeners();
                                        }
                                      } else {
                                        list[index].idTeam = -1;
                                        print(list[index]);
                                        playerValue.value[index] = list[index];
                                        playerValue.notifyListeners();
                                      }
                                    })
                              ],
                            )
                        );
                      },
                      separatorBuilder: (_, __) => Divider(),
                      itemCount: list.length,
                      shrinkWrap: true,
                    );
                  }
              ),
            )*/
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              // result(playerValue.value.where((element) => element.idTeam != -1).toList());
              Navigator.of(context).pop();
            },
            child: Text('Adicionar'),
          ),
        ],
      );
    },
  );
}