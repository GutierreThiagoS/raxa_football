import 'package:flutter/material.dart';
import 'package:football/controller/include_player_team_controller.dart';
import 'package:football/data/repository/player_soccer_repository_impl.dart';
import 'package:football/domain/models/player_soccer_full.dart';
import 'package:football/framework/components/outlined_text_filed.dart';

void showDialogEditPlayer(BuildContext context, PlayerSoccerFull player, Function(PlayerSoccerFull) result) {
  final controller = IncludePlayerTeamController(PlayerSoccerRepositoryImpl());

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Editar"),
        scrollable: true,
        content: Column(
          children: [
            Container(
                padding: EdgeInsets.all(20),
                child: OutlinedTextFiled(
                    labelText: "Editar jogador",
                    onChanged: controller.setPlayer)),
            Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save),
                      SizedBox(
                        width: 15,
                        height: 50,
                      ),
                      Text(
                        "Salvar",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                      ),
                    ],
                  ),
                  onPressed: () {
                    player.name = controller.player;
                    result(player);
                    Navigator.of(context).pop();
                  }),
            )
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              result(player);
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
        ],
      );
    },
  );
}
