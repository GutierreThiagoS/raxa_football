
import 'package:floor/floor.dart';
import 'package:football/domain/models_entity/game.dart';

@dao
abstract class GameDao {

  @insert
  Future<int> insertItem(Game item);

  @update
  Future<int> updateItem(Game item);

  @Query('SELECT * FROM Game')
  Future<List<Game>> getAll();

  @Query('SELECT * FROM Game WHERE finished = 0')
  Future<List<Game>> getAllNoFinish();

  @Query('SELECT * FROM Game WHERE id = :id LIMIT 1')
  Future<Game?> findById(int id);
}