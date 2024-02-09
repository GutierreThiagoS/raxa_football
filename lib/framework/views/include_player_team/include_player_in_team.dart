import 'package:flutter/material.dart';
import 'package:football/controller/include_player_team_controller.dart';
import 'package:football/framework/views/include_player_team/item_player_in_team.dart';

class IncludePlayerInTeam extends StatefulWidget {
  const IncludePlayerInTeam({super.key});

  @override
  State<
IncludePlayerInTeam> createState() => _IncludePlayerInTeamState();
}

class _IncludePlayerInTeamState extends State<IncludePlayerInTeam> {

  final controller = IncludePlayerTeamController();
  final players = ["jogador 1", "jogador 2", "jogador 3", "jogador 4", "jogador 5", "jogador 6", "jogador7", "jogador 8", "jogador 9", "jogador 10", "jogador 11", "jogador 12"];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Text("Incluir Jogador",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: Colors.white
              ),

            ),
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (_, index) {
                  return ItemPlayerInTeam(player: players[index]);
                }, 
                separatorBuilder: (_, __) => Divider(), 
                itemCount: players.length
            ),
          ),
        ],
      ),
    );
  }
}
