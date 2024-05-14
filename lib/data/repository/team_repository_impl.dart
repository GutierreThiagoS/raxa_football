import 'package:football/data/local/database.dart';
import 'package:football/domain/models_entity/team.dart';
import 'package:football/domain/repository/team_repository.dart';

class TeamRepositoryImpl extends TeamRepository {

  @override
  Future<List<Team>> getAllTeam() async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database_raxa.db').build();
      final teamDao = database.teamDao;
      final list = await teamDao.getAll();
      print("teamDao.getAll() $list");
      if(list.isNotEmpty) {
        return list;
      } else {
        await teamDao.insertItem(Team(name: "Time 1", image: "assets/team/camisa_ce.png"));
        await teamDao.insertItem(Team(name: "Time 2", image: "assets/team/camisa_azul.png"));
        await teamDao.insertItem(Team(name: "Time 3", image: "assets/team/camisa_verde.png"));
        return await teamDao.getAll();
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  @override
  Future<Team?> saveTeam(Team team) async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database_raxa.db').build();
      final teamDao = database.teamDao;
      final teamInName = await teamDao.getTeamInName(team.name, team.image);
      print("teamInName $teamInName");
      if (teamInName.isEmpty) {
        if (team.id == null) {
          await teamDao.insertItem(team);
          final teamInNameInsert = await teamDao.getTeamInName(team.name, team.image);
          return teamInNameInsert.first;
        } else {
          await teamDao.updateItem(team);
          return team;
        }
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}