
import 'package:flutter/material.dart';
import 'package:football/domain/models/team_checkbox.dart';
import 'package:football/domain/models_entity/team.dart';

void dialogSelectNewGame(
    BuildContext context,
    List<Team> teams,
    Function(List<TeamCheckbox>) confirm
    ) {

  ValueNotifier<List<TeamCheckbox>> teamCheckbox = ValueNotifier(teams.map((e) => TeamCheckbox(team: e, checkedIndex: 0)).toList());

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Selecione os times para nova partida"),
        scrollable: true,
        content: Container(
            width: MediaQuery.of(context).size.width *  0.9,
            height: MediaQuery.of(context).size.height *  0.4,
            child:  SingleChildScrollView(
              child: ValueListenableBuilder(
                  valueListenable: teamCheckbox,
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
                                  flex: 1,
                                  child: Image.asset(list[index].team.image),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    list[index].checkedIndex > 0
                                        ? "${list[index].checkedIndex} ${list[index].team.name}"
                                        : "${list[index].team.name}",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ),
                                Checkbox(value: list[index].checkedIndex > 0,
                                    onChanged: (value) {
                                      print(value);
                                      if (value != null && value) {
                                        final checkedIndex = teamCheckbox.value.where((element) => element.checkedIndex > 0).toList().length;
                                        if(checkedIndex < 2) {
                                          list[index].checkedIndex = checkedIndex + 1;
                                          print(list[index]);
                                          teamCheckbox.value[index] = list[index];
                                          teamCheckbox.notifyListeners();
                                        }
                                      } else {
                                        teamCheckbox.value[index].checkedIndex = 0;
                                        print(list[index]);
                                        teamCheckbox.value[index] = list[index];
                                        teamCheckbox.notifyListeners();
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
            ),
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
              final teamCheckboxList = teamCheckbox.value.where((element) => element.checkedIndex > 0).toList();
              if (teamCheckboxList.length == 2) {
                confirm(teamCheckboxList);
              }
              Navigator.of(context).pop();
            },
            child: Text('Criar'),
          ),
        ],
      );
    },
  );
}