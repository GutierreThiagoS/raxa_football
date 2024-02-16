import 'package:flutter/material.dart';
import 'package:football/controller/include_player_team_controller.dart';
import 'package:football/controller/my_team_controller.dart';
import 'package:football/data/repository/player_soccer_repository_impl.dart';
import 'package:football/data/repository/team_repository_impl.dart';
import 'package:football/domain/models_entity/player_soccer.dart';
import 'package:football/domain/models_entity/team.dart';
import 'package:football/framework/components/outlined_text_filed.dart';

class CreateFootballPlayer extends StatefulWidget {
  final Function(PlayerSoccer?)? returnCreated;
  final int? team;
  const CreateFootballPlayer({super.key, this.returnCreated, this.team});

  @override
  State<CreateFootballPlayer> createState() => _CreateFootballPlayerState();
}

class _CreateFootballPlayerState extends State<CreateFootballPlayer> {

  final controller = IncludePlayerTeamController(PlayerSoccerRepositoryImpl());
  final controllerTeam = MyTeamController(TeamRepositoryImpl());
  List<Team> teams = [Team(name: "Sem time")];

  String dropdownValue = "Sem time";

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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          widget.returnCreated == null ? Container(
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
          ) : Container(),
          Container(
            padding: EdgeInsets.all(20),
              child: OutlinedTextFiled(labelText: "Nome do jogador", onChanged: controller.setPlayer)
          ),
          widget.returnCreated == null ? Container(
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.topLeft,
            child: DropdownButton<String>(
              alignment: AlignmentDirectional.topStart,
                value: dropdownValue,
                items: teams.map<DropdownMenuItem<String>>((Team value) {
                  return DropdownMenuItem<String>(
                    value: value.name,
                    child: Text(value.name,
                      style: TextStyle(
                          fontSize: 17,
                          color: value.name != "Sem time"? Colors.black: Colors.black38
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    if(value != null) {
                      dropdownValue = value;
                    }
                  });
                }
            ),
          ): Container(),
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
                  controller.savePlayer(
                    widget.team != null
                        ? widget.team?? -1
                        : teams.firstWhere((element) => element.name == dropdownValue).id ??-1
                  ).then((value) {
                    if(widget.returnCreated != null) {
                      widget.returnCreated!(value);
                    }
                  });
                }
            ),
          )
        ],
      ),
    );
  }
}
