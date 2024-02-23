
import 'package:football/data/local/database.dart';
import 'package:football/domain/models_entity/player_in_team.dart';
import 'package:football/domain/models_entity/player_soccer.dart';
import 'package:football/domain/repository/player_in_team_repository.dart';

class PlayerInTeamRepositoryImpl extends PlayerInTeamRepository {
  @override
  Future<PlayerSoccer?> savePlayerInTeam(int teamId, int playerId) async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database_raxa.db').build();
      final gameDao = database.gameDao;
      final dao = database.playerInTeamDao;

      final gamesList = await gameDao.getAllNoFinish();
      final game = gamesList.first;

      final playerInTeam = await dao.findPlayerInTeam(game.id??0, playerId, teamId);

      if (playerInTeam == null) {
        dao.insertItem(PlayerInTeam(gameId: game.id??0, playerId: playerId, teamId: teamId));
      } else {
        return null;
      }

    } catch (e) {
      print("ERROR savePlayerInTeam $e");
      return null;
    }
  }

}