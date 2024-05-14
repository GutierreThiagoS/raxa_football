
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