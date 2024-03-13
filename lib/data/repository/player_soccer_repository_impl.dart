
import 'package:football/data/local/database.dart';
import 'package:football/domain/models/player_soccer_full.dart';
import 'package:football/domain/models_entity/player_soccer.dart';
import 'package:football/domain/repository/player_soccer_repository.dart';

class PlayerSoccerRepositoryImpl extends PlayerSoccerRepository {

  @override
  Future<List<PlayerSoccer>> getAllPlayerSoccer() async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database_raxa.db').build();
      final dao = database.playerSoccerDao;
      return await dao.getAll();
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  @override
  Future<List<PlayerSoccerFull>> getAllPlayerSoccerFull() async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database_raxa.db').build();
      final playerDao = database.playerInTeamDao;
      final list = await getAllPlayerSoccer();
      List<PlayerSoccerFull> players = [];
      for (var e in list) {
        print(e);
        final goalsList = await playerDao.getTotalGoals(e.id??0);
        final count = await playerDao.getTotalGamesCount(e.id??0);
        final teamId = await playerDao.getTeamInPlayerId(e.id??0);
        print("$goalsList, $count, $teamId");

        players.add(PlayerSoccerFull(
            id: e.id??0,
            name: e.name,
            level: e.level,
            presented: e.presented,
            goals: goalsList.isNotEmpty ? goalsList.reduce((value, element) => value + element) : 0,
            gamesCount: count??0,
            teamId: teamId??0
        ));
      }

      return players;
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  @override
  Future<PlayerSoccer?> savePlayerSoccer(PlayerSoccer item) async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database_raxa.db').build();
      final dao = database.playerSoccerDao;
      print("PlayerSoccer item $item");
      final playerInName = await dao.getAllInName(item.name);
      print("PlayerSoccer playerInName $playerInName");
      if(playerInName.isEmpty) {
        if(item.id == null) {
          await dao.insertItem(item);
          final newItems = await dao.getAllInName(item.name);
          return newItems.first;
        } else {
          await dao.updateItem(item);
          return item;
        }
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  @override
  Future<PlayerSoccerFull?> savePlayerSoccerFull(PlayerSoccerFull item) async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database_raxa.db').build();
      final dao = database.playerSoccerDao;
      final playerDao = database.playerInTeamDao;
      print("PlayerSoccer item $item");
      final player = await dao.findById(item.id);
      if(player != null) {
        player.name = item.name;
        player.level = item.level;
        player.presented = item.presented;
        await dao.updateItem(player);

        final playerInTeam = await playerDao.getPlayerInTeamNotFinish(player.id??0);
        if (playerInTeam != null && playerInTeam.teamId != item.teamId) {
          final teamList = await playerDao.getAllTeamInPlayer(playerInTeam.teamId);
          if (teamList.length < 5) {
            playerInTeam.teamId = item.teamId;
            playerInTeam.name = item.name;
            playerDao.updateItem(playerInTeam);
            return item;
          } else {
            item.teamId = playerInTeam.teamId;
            return item;
          }
        }
        return item;
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  @override
  Future<List<PlayerSoccer>> getAllPlayerSoccerNotTeam() async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database_raxa.db').build();
      final dao = database.playerSoccerDao;

      print("dao.getAllNotTeam() ${await dao.getAllNotTeam()}");

      return await dao.getAllNotTeam();

    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  @override
  Future<PlayerSoccer?> removerPlayerInTeam(PlayerSoccer playerSoccer) async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database_raxa.db').build();
      final dao = database.playerSoccerDao;
      // playerSoccer.idTeam = -1;

      final up = await dao.updateItem(playerSoccer);
      if (up > 0) {
        return playerSoccer;
      } else {
        return null;
      }
    } catch (e) {
    print("Error: $e");
    return null;
    }
  }



}