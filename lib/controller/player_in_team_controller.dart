import 'package:flutter/cupertino.dart';
import 'package:football/domain/models_entity/player_in_team.dart';
import 'package:football/domain/models_entity/player_soccer.dart';
import 'package:football/domain/models_entity/team.dart';
import 'package:football/domain/repository/player_in_team_repository.dart';

class PlayerInTeamController {


  final PlayerInTeamRepository _repository;

  PlayerInTeamController(this._repository);

  ValueNotifier<List<PlayerInTeam>> playerInTeamList = ValueNotifier([]);

  Future<Team?> getTeamInPlayer(int playerId) async {
    return await _repository.getTeamInPlayer(playerId);
  }

  Future<int> getTotalGoals(PlayerSoccer player) async {
    return await _repository.getTotalGoals(player);
  }

  Future<int> getTotalGames(PlayerSoccer player) async {
    return await _repository.getTotalGames(player);
  }

  Future<PlayerInTeam?> savePlayerInTeam(int teamId, int playerId) async {
    return await _repository.savePlayerInTeam(teamId, playerId);
  }

  Future<PlayerInTeam?> removerPlayerInTeam(PlayerInTeam player) async {
    return await _repository.removerPlayerInTeam(player);
  }

  Future<List<PlayerInTeam>> updateAllPlayerSoccer(List<PlayerSoccer> items, int idTeam) async {
    print("savePlayer player $items");
    List<PlayerInTeam> listUp = [];
    for (var item in items) {
      final up = await _repository.savePlayerInTeam(idTeam, item.id??0);
      if (up != null) {
        listUp.add(up);
      }
    }
    return listUp;
  }

}