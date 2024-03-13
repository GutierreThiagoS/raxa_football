import 'package:flutter/material.dart';
import 'package:football/controller/include_player_team_controller.dart';
import 'package:football/controller/my_team_controller.dart';
import 'package:football/data/repository/player_soccer_repository_impl.dart';
import 'package:football/data/repository/team_repository_impl.dart';
import 'package:football/domain/models_entity/team.dart';
import 'package:football/framework/views/include_player_team/item_player_in_team.dart';

class IncludePlayerInTeam extends StatefulWidget {
  const IncludePlayerInTeam({super.key});

  @override
  State<IncludePlayerInTeam> createState() => _IncludePlayerInTeamState();
}

class _IncludePlayerInTeamState extends State<IncludePlayerInTeam> {

  final controller = IncludePlayerTeamController(PlayerSoccerRepositoryImpl());
  final controllerTeam = MyTeamController(TeamRepositoryImpl());

  List<Team> teams = [Team(name: "Sem time")];

  @override
  void initState() {
    super.initState();
    Future.wait([
      controllerTeam.getTeamListAsync()
    ]).then((value) {
      setState(() {
        teams.addAll(value[0]);
      });
    });
    controller.getAllPlayerSoccerFull();
  }
  
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
            child:  ValueListenableBuilder(
            valueListenable: controller.playerSoccerList,
            builder:(_, list, __) => ListView.separated(
                    itemBuilder: (_, index) {
                      return ItemPlayerInTeam(
                          player: list[index],
                          teams: teams,
                          updatePlayerSoccer: (playerSoccer, result) {
                            controller.savePlayerSoccerFull(playerSoccer, index)
                                .then(result);
                          });
                    }, 
                    separatorBuilder: (_, __) => Divider(), 
                    itemCount: list.length
                ),
              ),
            ),
        ],
      ),
    );
  }
}
