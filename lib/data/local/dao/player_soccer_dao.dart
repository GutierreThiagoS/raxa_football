
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

  @Query('SELECT * FROM PlayerSoccer WHERE idTeam = -1')
  Future<List<PlayerSoccer>> getAllNotTeam();

  @Query('SELECT * FROM PlayerSoccer WHERE name = :name')
  Future<List<PlayerSoccer>> getAllInName(String name);

  @Query('SELECT * FROM PlayerSoccer WHERE idTeam = :team')
  Future<List<PlayerSoccer>> getAllInTeam(int team);
}