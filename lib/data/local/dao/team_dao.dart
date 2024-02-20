
import 'package:floor/floor.dart';
import 'package:football/domain/models_entity/team.dart';

@dao
abstract class TeamDao {

  @insert
  Future<int> insertItem(Team team);

  @update
  Future<int> updateItem(Team team);

  @Query('SELECT * FROM Team')
  Future<List<Team>> getAll();

  @Query('SELECT * FROM Team WHERE name = :name AND image = :image')
  Future<List<Team>> getTeamInName(String name, String image);

  @Query('SELECT * FROM Team WHERE id IN (:teams)')
  Future<List<Team>> getTeamInGame(List<int> teams);
}