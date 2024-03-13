
import 'package:floor/floor.dart';
import 'package:football/domain/models_entity/configuration.dart';

@dao
abstract class ConfigurationDao {

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertItem(Configuration item);

  @update
  Future<int> updateItem(Configuration item);

  @Query('SELECT * FROM Configuration')
  Future<List<Configuration>> getAll();

  @Query('SELECT * FROM Configuration WHERE finished = 0')
  Future<List<Configuration>> getAllNoFinish();

  @Query('SELECT * FROM Configuration WHERE id = :id LIMIT 1')
  Future<Configuration?> findById(int id);
}