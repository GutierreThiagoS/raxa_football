
import 'package:floor/floor.dart';
import 'package:football/domain/models_entity/player_soccer.dart';

@dao
abstract class PlayerSoccerDao {

  @insert
  Future<int> insertItem(PlayerSoccer item);

  @update
  Future<int> updateItem(PlayerSoccer item);

  @Query('SELECT * FROM PlayerSoccer')
  Future<List<PlayerSoccer>> getAll();

  @Query(
      'SELECT PS.* FROM PlayerSoccer PS WHERE '
        'NOT EXISTS ('
          'SELECT * FROM PlayerInTeam PI '
          'INNER JOIN Team T ON PI.teamId = T.id '
          'INNER JOIN Game G ON G.id = PI.gameId '
          'WHERE PI.playerId = PS.id '
          'AND G.finished = 0 '
        ')')
  Future<List<PlayerSoccer>> getAllNotTeam();

  @Query('SELECT * FROM PlayerSoccer WHERE name = :name')
  Future<List<PlayerSoccer>> getAllInName(String name);

  @Query('SELECT * FROM PlayerSoccer WHERE id = :id')
  Future<PlayerSoccer?> findById(int id);

  @Query('SELECT * FROM PlayerSoccer WHERE id = :id LIMIT 1')
  Future<PlayerSoccer?> getById(int id);

  @Query('SELECT * FROM PlayerSoccer WHERE idTeam = :team')
  Future<List<PlayerSoccer>> getAllInTeam(int team);
}