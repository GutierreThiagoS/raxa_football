
import 'package:flutter/material.dart';
import 'package:football/domain/models_entity/team.dart';
import 'package:football/framework/components/outlined_text_filed.dart';

import '../dialog/dialog_add_image.dart';

class ItemTeam extends StatefulWidget {
  final Team team;
  final List<String> imageTeams;
  final Function(Team) saveTeam;
  const ItemTeam({super.key, required this.team, required this.saveTeam, required this.imageTeams});

  @override
  State<ItemTeam> createState() => _ItemTeamState();
}

class _ItemTeamState extends State<ItemTeam> {

  void onChange(String value) {
    print("VALUE $value");
    widget.team.name = value;
  }

  ValueNotifier<bool> isEdit = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 15, right: 15),
      child: ValueListenableBuilder(
        valueListenable: isEdit,
        builder: (_, edit, __) {
          return edit ?
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: OutlinedTextFiled(
                  labelText: "Editar Time",
                  hintText: widget.team.name,
                  onChanged: onChange,
                ),
              ),
              IconButton(onPressed: () {
                print("widget.team ${widget.team}");
                widget.saveTeam(widget.team);
                isEdit.value = false;
              }, icon: Icon(Icons.save))
            ],
          )
          : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                  child: InkWell(
                    onTap: () => {
                      showDialogAddImage(
                        context,
                          widget.imageTeams,
                        (value) {
                          widget.team.image = value;
                          widget.saveTeam(widget.team);
                        },
                      )
                    },
                    child: Ink(
                      padding: EdgeInsets.all(10),
                        child: Image.asset(widget.team.image)
                    ),
                  )
              ),
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Text(
                      widget.team.name,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(onPressed: () {
                isEdit.value = true;
              }, icon: Icon(Icons.edit_outlined))
            ],
          );
        }
      ),
    );
  }
}
