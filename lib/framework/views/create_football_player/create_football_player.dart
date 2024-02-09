import 'package:flutter/material.dart';
import 'package:football/framework/components/outlined_text_filed.dart';
import 'package:football/framework/controller/include_player_team_controller.dart';

class CreateFootballPlayer extends StatefulWidget {
  const CreateFootballPlayer({super.key});

  @override
  State<CreateFootballPlayer> createState() => _CreateFootballPlayerState();
}

class _CreateFootballPlayerState extends State<CreateFootballPlayer> {

  final controller = IncludePlayerTeamController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Text("Criar Jogador",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.white
              ),

            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
              child: OutlinedTextFiled(labelText: "Nome do jogador", onChanged: controller.setPlayer)
          ),
          Container(
            padding: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save),
                    SizedBox(width: 15, height: 50,),
                    Text(
                      "Salvar",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2
                      ),
                    ),
                  ],
                ),
                onPressed: () {

                }
            ),
          )
        ],
      ),
    );
  }
}
