
import 'package:flutter/cupertino.dart';
import 'package:football/domain/models_entity/player_soccer.dart';
import 'package:football/domain/repository/player_soccer_repository.dart';

class IncludePlayerTeamController {

  final PlayerSoccerRepository _repository;

  IncludePlayerTeamController(this._repository);

  String player = "";
  setPlayer(value) => player = value;

  ValueNotifier<List<PlayerSoccer>> playerSoccerList = ValueNotifier([]);

  Future<void> getAllPlayers() async {
    playerSoccerList.value =  await _repository.getAllPlayerSoccer();
  }
  
  Future<PlayerSoccer?> savePlayer(int teamId) async {
    print("savePlayer player $player");
    return await _repository.savePlayerSoccer(PlayerSoccer(name: player, idTeam: teamId));
  }

  Future<PlayerSoccer?> savePlayerSoccer(PlayerSoccer item, int index) async {
    print("savePlayer player $player");
    final savePlayer = await _repository.savePlayerSoccer(item);
    print("savePlayer savePlayer $savePlayer");

    if (savePlayer != null) {
      playerSoccerList.value[index] = savePlayer;
    }
    return savePlayer;
  }

  Future<List<PlayerSoccer>> updateAllPlayerSoccer(List<PlayerSoccer> items) async {
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