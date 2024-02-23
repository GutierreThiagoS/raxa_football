
import 'package:floor/floor.dart';
import 'package:football/domain/models_entity/player_in_team.dart';

@dao
abstract class PlayerInTeamDao {

  @insert
  Future<int> insertItem(PlayerInTeam item);

  @update
  Future<int> updateItem(PlayerInTeam item);

  @Query('SELECT * FROM PlayerInTeam')
  Future<List<PlayerInTeam>> getAll();

  @Query('SELECT * FROM PlayerInTeam '
      'WHERE gameId = :gameId '
      'AND playerId = :playerId '
      'AND teamId = :teamId '
      'LIMIT 1')
  Future<PlayerInTeam?> findPlayerInTeam(int gameId, int playerId, int teamId);

}