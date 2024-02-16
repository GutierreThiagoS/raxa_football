import 'package:football/domain/models_entity/team.dart';

abstract class TeamRepository {

  Future<List<Team>> getAllTeam();

  Future<Team?> saveTeam(Team team);
}