
import 'package:floor/floor.dart';
import 'package:football/domain/models_entity/team.dart';

@dao
abstract class TeamDao {

  @insert
  Future<int> insertItem(Team team);

  @insert
  Future<List<int>> insertAll(List<Team> teams);

  @Query('SELECT * FROM Team')
  Future<List<Team>> getAll();
}