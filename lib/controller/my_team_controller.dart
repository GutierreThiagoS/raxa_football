
import 'package:flutter/cupertino.dart';
import 'package:football/domain/models_entity/team.dart';
import 'package:football/domain/repository/team_repository.dart';

class MyTeamController {

  final TeamRepository _repository;

  MyTeamController(this._repository);

  ValueNotifier<List<Team>> teamList = ValueNotifier([]);

  Future<void> getTeamList() async {
    teamList.value = await _repository.getAllTeam();
  }

  Future<List<Team>> getTeamListAsync() async {
    return await _repository.getAllTeam();
  }

  Future<void> saveTeam(Team team, int index) async {
    final teamSave = await _repository.saveTeam(team);
    if (teamSave != null) {
      teamList.value[index] = teamSave;
    }
  }

}