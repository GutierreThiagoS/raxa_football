import 'package:flutter/material.dart';
import 'package:football/domain/models_entity/player_soccer.dart';
import 'package:football/domain/models_entity/team.dart';

class ItemPlayerInTeam extends StatefulWidget {
  final PlayerSoccer player;
  final List<Team> teams;
  final Function(PlayerSoccer, Function(PlayerSoccer?)) updatePlayerSoccer;
  const ItemPlayerInTeam({super.key, required this.player, required this.teams, required this.updatePlayerSoccer});

  @override
  State<ItemPlayerInTeam> createState() => _ItemPlayerInTeamState();
}

class _ItemPlayerInTeamState extends State<ItemPlayerInTeam> {

  String dropdownValue = "Sem time";

  @override
  void initState() {
    super.initState();
    if(widget.player.idTeam != -1) {
      dropdownValue = widget.teams.firstWhere((element) => element.id == widget.player.idTeam).name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                      widget.player.name,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                    items: widget.teams.map<DropdownMenuItem<String>>((Team value) {
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
                          final oldDropdownValue = dropdownValue;
                          dropdownValue = value;
                          widget.player.idTeam = widget.teams.firstWhere((element) => element.name == dropdownValue).id ??-1;
                          widget.updatePlayerSoccer(widget.player, (player) {
                            if (player == null) {
                              setState(() {
                                dropdownValue = oldDropdownValue;
                              });
                            }
                          });
                        }
                      });
                    }
                )
              ],
            ),
            Row(
              children: [
                Text("Gols ${widget.player.gols}"),
                SizedBox(width: 10),
                Text("Partidas ${widget.player.partidas}"),
              ],
            )
          ],
        )
    );
  }
}
