import 'package:flutter/material.dart';

class ItemPlayerInTeam extends StatefulWidget {
  final String player;
  const ItemPlayerInTeam({super.key, required this.player});

  @override
  State<ItemPlayerInTeam> createState() => _ItemPlayerInTeamState();
}

class _ItemPlayerInTeamState extends State<ItemPlayerInTeam> {

  final times = ["Sem time", "Time 1", "Time 2", "Time 3"];
  String dropdownValue = "Sem time";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                  widget.player,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
            DropdownButton<String>(
              value: dropdownValue,
                items: times.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                      style: TextStyle(
                      fontSize: 17,
                        color: value != "Sem time"? Colors.black: Colors.black38
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
            )
          ],
        )
    );
  }
}
