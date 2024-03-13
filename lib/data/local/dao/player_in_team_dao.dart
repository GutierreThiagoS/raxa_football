
import 'package:floor/floor.dart';
import 'package:football/domain/models_entity/player_in_team.dart';
import 'package:football/domain/models_entity/team.dart';

@dao
abstract class PlayerInTeamDao {

  @insert
  Future<int> insertItem(PlayerInTeam item);

  @update
  Future<int> updateItem(PlayerInTeam item);

  @delete
  Future<int> deleteItem(PlayerInTeam item);

  @Query('SELECT * FROM PlayerInTeam WHERE gameId = :idGame AND teamId = :idTeam')
  Future<List<PlayerInTeam>> getAllInIdGameAndTeamId(int idGame, int idTeam);

  @Query(
      'SELECT DISTINCT T.* FROM Team T '
      'LEFT JOIN PlayerInTeam PI ON PI.teamId = T.id '
      'WHERE gameId = :idGame '
  )
  Future<List<Team>> getIdTeamsInPlayerInTeam(int idGame);

  @Query(
      'SELECT T.* FROM Team T '
          'LEFT JOIN PlayerInTeam PI ON PI.teamId = T.id '
          'INNER JOIN Game G ON G.id = PI.gameId '
          'WHERE PI.playerId = :playerId '
          'AND G.finished = 0 '
          'LIMIT 1 '
  )
  Future<Team?> getTeamInPlayer(int playerId);

  @Query(
      'SELECT T.id FROM Team T '
          'LEFT JOIN PlayerInTeam PI ON PI.teamId = T.id '
          'INNER JOIN Game G ON G.id = PI.gameId '
          'WHERE PI.playerId = :playerId '
          'AND G.finished = 0 '
          'LIMIT 1 '
  )
  Future<int?> getTeamInPlayerId(int playerId);

  @Query(
      'SELECT PI.* FROM PlayerInTeam PI '
          'LEFT JOIN Team T ON PI.teamId = T.id '
          'INNER JOIN Game G ON G.id = PI.gameId '
          'WHERE PI.playerId = :playerId '
          'AND G.finished = 0 '
          'LIMIT 1 '
  )
  Future<PlayerInTeam?> getPlayerInTeamNotFinish(int playerId);

  @Query(
      'SELECT T.* FROM Team T '
          'LEFT JOIN PlayerInTeam PI ON PI.teamId = T.id '
          'INNER JOIN Game G ON G.id = PI.gameId '
          'WHERE PI.teamId = :idTeam '
          'AND G.finished = 0'
  )
  Future<List<Team>> getAllTeamInPlayer(int idTeam);

  @Query('SELECT goals FROM PlayerInTeam WHERE playerId = :playerId')
  Future<List<int>> getTotalGoals(int playerId);

  @Query('SELECT COUNT(*) FROM PlayerInTeam WHERE playerId = :playerId')
  Future<int?> getTotalGamesCount(int playerId);

  @Query(
      'SELECT * FROM PlayerInTeam '
      'WHERE playerId = :playerId '
          'AND teamId = :teamId '
          'AND gameId = :gameId '
          'LIMIT 1'
  )
  Future<PlayerInTeam?> findPlayerInTeam(int gameId, int playerId, int teamId);
}