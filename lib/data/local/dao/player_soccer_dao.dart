
import 'package:floor/floor.dart';
import 'package:football/domain/models_entity/player_soccer.dart';

@dao
abstract class PlayerSoccerDao {

  @insert
  Future<int> insertItem(PlayerSoccer item);

  @insert
  Future<List<int>> insertAll(List<PlayerSoccer> players);

  @Query('SELECT * FROM PlayerSoccer')
  Future<List<PlayerSoccer>> getAll();
}