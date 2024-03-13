
import 'package:football/data/local/database.dart';
import 'package:football/domain/models_entity/player_in_team.dart';
import 'package:football/domain/models_entity/player_soccer.dart';
import 'package:football/domain/models_entity/team.dart';
import 'package:football/domain/repository/player_in_team_repository.dart';

class PlayerInTeamRepositoryImpl extends PlayerInTeamRepository {
  @override
  Future<PlayerInTeam?> savePlayerInTeam(int teamId, int playerId) async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database_raxa.db').build();
      final gameDao = database.gameDao;
      final dao = database.playerInTeamDao;
      final playerDao = database.playerSoccerDao;

      final gamesList = await gameDao.getAllNoFinish();
      final game = gamesList.first;
      final player = await playerDao.getById(playerId);

      final playerInTeam = await dao.findPlayerInTeam(game.id??0, playerId, teamId);

      if (playerInTeam == null) {
        final listItemsInTeam = await dao.getAllTeamInPlayer(teamId);

        if (listItemsInTeam.length < 5) {
          await dao.insertItem(
              PlayerInTeam(
                gameId: game.id??0,
                playerId: playerId,
                teamId: teamId,
                name: player?.name??"",
              )
          );
          return await dao.findPlayerInTeam(game.id??0, playerId, teamId);
        } else {
          return null;
        }

      } else {
        return null;
      }

    } catch (e) {
      print("ERROR savePlayerInTeam $e");
      return null;
    }
  }

  @override
  Future<Team?> getTeamInPlayer(int playerId) async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database_raxa.db').build();
      final dao = database.playerInTeamDao;

      return await dao.getTeamInPlayer(playerId);
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  @override
  Future<int> getTotalGoals(PlayerSoccer playerSoccer) async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database_raxa.db').build();
      final dao = database.playerInTeamDao;

      final goals = await dao.getTotalGoals(playerSoccer.id??0);
      return goals.reduce((value, element) => value + element);
    } catch (e) {
      print("Error: $e");
      return 0;
    }
  }


  @override
  Future<int> getTotalGames(PlayerSoccer playerSoccer) async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database_raxa.db').build();
      final dao = database.playerInTeamDao;

      final count = await dao.getTotalGamesCount(playerSoccer.id??0);
      return count??0;
    } catch (e) {
      print("Error: $e");
      return 0;
    }
  }

  @override
  Future<PlayerInTeam?> removerPlayerInTeam(PlayerInTeam playerSoccer) async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database_raxa.db').build();
      final dao = database.playerInTeamDao;
      // playerSoccer.idTeam = -1;

      final up = await dao.deleteItem(playerSoccer);
      if (up > 0) {
        return playerSoccer;
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

}