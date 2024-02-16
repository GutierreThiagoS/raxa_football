
import 'package:football/data/local/database.dart';
import 'package:football/domain/models_entity/player_soccer.dart';
import 'package:football/domain/repository/player_soccer_repository.dart';

class PlayerSoccerRepositoryImpl extends PlayerSoccerRepository {

  @override
  Future<List<PlayerSoccer>> getAllPlayerSoccer() async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database_raxa.db').build();
      final dao = database.playerSoccerDao;

      print("dao.getAll() ${await dao.getAll()}");

      return await dao.getAll();

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
        if (playerInName.first.idTeam != item.idTeam && item.id != null) {
          final listItemsInTeam = await dao.getAllInTeam(item.idTeam);
          if (listItemsInTeam.length < 5 || item.idTeam == -1) {
            await dao.updateItem(item);
            return item;
          } else {
            return null;
          }

        } else {
          return null;
        }
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

      print("dao.getAll() ${await dao.getAllNotTeam()}");

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
      playerSoccer.idTeam = -1;

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