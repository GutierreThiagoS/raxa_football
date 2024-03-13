
import 'package:flutter/cupertino.dart';
import 'package:football/domain/models/player_soccer_full.dart';
import 'package:football/domain/models_entity/player_soccer.dart';
import 'package:football/domain/repository/player_soccer_repository.dart';

class IncludePlayerTeamController {

  final PlayerSoccerRepository _repository;

  IncludePlayerTeamController(this._repository);

  String player = "";
  setPlayer(value) => player = value;

  ValueNotifier<List<PlayerSoccerFull>> playerSoccerList = ValueNotifier([]);

  Future<void> getAllPlayerSoccerFull() async {
    playerSoccerList.value = await _repository.getAllPlayerSoccerFull();
  }

  Future<List<PlayerSoccer>> getAllPlayersValue() async {
    return await _repository.getAllPlayerSoccer();
  }
  
  Future<PlayerSoccer?> savePlayer(int teamId) async {
    print("savePlayer player $player");
    return await _repository.savePlayerSoccer(PlayerSoccer(name: player));
  }

  Future<PlayerSoccerFull?> savePlayerSoccerFull(PlayerSoccerFull item, int index) async {
    print("savePlayer player $player");
    final savePlayer = await _repository.savePlayerSoccerFull(item);
    print("savePlayer savePlayer $savePlayer");

    if (savePlayer != null && index != -1) {
      playerSoccerList.value[index] = savePlayer;
    }
    return savePlayer;
  }

  Future<List<PlayerSoccer>> updateAllPlayerSoccer(List<PlayerSoccer> items, int idTeam) async {
    print("savePlayer player $player");
    List<PlayerSoccer> listUp = [];
    for (var item in items) {
      final up = await _repository.savePlayerSoccer(item);
      if (up != null) {
        listUp.add(up);
      }
    }
    return listUp;
  }

  Future<List<PlayerSoccer>> getAllPlayersNotTeam() async {
    return await _repository.getAllPlayerSoccerNotTeam();
  }

  Future<PlayerSoccer?> removerPlayerInTeam(PlayerSoccer player) async {
    return await _repository.removerPlayerInTeam(player);
  }

}