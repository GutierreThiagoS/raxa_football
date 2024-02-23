
import 'package:football/data/local/database.dart';
import 'package:football/domain/models/game_and_teams.dart';
import 'package:football/domain/models/team_and_players.dart';
import 'package:football/domain/models/team_checkbox.dart';
import 'package:football/domain/models_entity/game.dart';
import 'package:football/domain/models_entity/player_soccer.dart';
import 'package:football/domain/models_entity/team.dart';
import 'package:football/domain/repository/game_repository.dart';
import 'package:intl/intl.dart';

class GameRepositoryImpl extends GameRepository {

  @override
  Future<Game?> getGameData() async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database_raxa.db').build();
      final dao = database.gameDao;

      final list = await dao.getAll();

      if (list.isEmpty) {
        final teamDao = database.teamDao;
        final teamList = await teamDao.getAll();
        if (teamList.length > 1) {

          DateTime date = DateTime.now();
          DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
          final dateTime = dateFormat.format(date);

          await dao.insertItem(
              Game(
                  idTeam1: teamList.first.id??0,
                  idTeam2: teamList[1].id??1,
                  dateTimeCreated: dateTime
              )
          );
          final listGame = await dao.getAll();
          return listGame.first;
        } else {
          return null;
        }
      } else {
        return list.firstOrNull;
      }

    } catch (e) {
      print("GameRepository failed $e");
      return null;
    }
  }

  @override
  Future<GameAndTeams?> getGameAndTeams() async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database_raxa.db').build();
      final dao = database.gameDao;
      final games = await dao.getAllNoFinish();
      final game = games.firstOrNull;

      if(game != null) {
        final teamDao = database.teamDao;
        final playerDao = database.playerSoccerDao;
        final teams = await teamDao.getTeamInGame([game.idTeam1, game.idTeam2]);

        if(teams.length > 1) {
          final teamFirst = teams.firstWhere((e) => game.idTeam1 == e.id);
          final teamSecond = teams.firstWhere((e) => game.idTeam2 == e.id);
          return GameAndTeams(
              game: game,
              teamAndPlayers1: TeamAndPlayers(
                  team: teamFirst,
                  players: await playerDao.getAllInTeam(teamFirst.id??-2)
              ),
              teamAndPlayers2: TeamAndPlayers(
                  team: teamSecond,
                  players: await playerDao.getAllInTeam(teamSecond.id??-2)
              )
          );
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print("GameRepository failed $e");
      return null;
    }
  }

  @override
  Future<Game?> initGame(Game game) async {
    try {

      final database = await $FloorAppDatabase.databaseBuilder('app_database_raxa.db').build();
      final dao = database.gameDao;

      DateTime dateInit = DateTime.now();
      DateTime dateFinal = dateInit.add(Duration(minutes: game.time));
      DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');

      game.dateTimeInit = dateFormat.format(dateInit);
      game.dateTimeFinish = dateFormat.format(dateFinal);
      game.initGame = true;

      if(game.id != null) {
        dao.updateItem(game);
        return await dao.findById(game.id!);
      } else {
        final id = await dao.insertItem(game);
        print("id $id");
        return await dao.findById(id);
      }
    } catch (e) {
      print("GameRepository failed $e");
      return null;
    }
  }

  @override
  Future<void> getPlayerSoccer() async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database_raxa.db').build();
      final dao = database.playerSoccerDao;

      final players = await dao.getAll();

      if(players.isEmpty) {
        for (var i = 1; i <= 15; i++) {
          dao.insertItem(PlayerSoccer(name: "Jogador $i"));
        }
      }

    } catch (e) {
      print("getPlayerSoccer failed $e");
    }
  }

  @override
  Future<void> registerGolGame(Team team, PlayerSoccer playerSoccer) async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database_raxa.db').build();
      final dao = database.playerSoccerDao;
      final teamDao = database.teamDao;

      await dao.updateItem(playerSoccer);
      await teamDao.updateItem(team);
    } catch (e) {
      print("registerGolGame failed $e");
    }
  }

  @override
  Future<List<Team>> getTeams() async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database_raxa.db').build();
      final dao = database.teamDao;

      return await dao.getAll();
    } catch (e) {
      print("getTeams failed $e");
      return [];
    }
  }

  @override
  Future<GameAndTeams?> newGameData(List<TeamCheckbox> list) async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database_raxa.db').build();
      final dao = database.gameDao;
      final teamDao = database.teamDao;

      print("checkedIndex $list");

      final gamesOld = await dao.getAllNoFinish();


      if (list.length > 1) {
        final idTeam1 = list.firstWhere((element) => element.checkedIndex == 1).team.id??0;
        final idTeam2 = list.firstWhere((element) => element.checkedIndex == 2).team.id??1;

        if(gamesOld.where((e) => e.dateTimeInit.isEmpty).isEmpty) {
          for (var e in gamesOld) {
            e.finished = true;
            await dao.updateItem(e);
          }
          DateTime date = DateTime.now();
          DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
          final dateTime = dateFormat.format(date);

          await dao.insertItem(
              Game(
                  idTeam1: idTeam1,
                  idTeam2: idTeam2,
                  dateTimeCreated: dateTime
              )
          );

          final teamList = await teamDao.getAll();
          for (var element in teamList) {
            element.gol = 0;
            await teamDao.updateItem(element);
          }
          return await getGameAndTeams();
        } else {

          final game = gamesOld.firstWhere((e) => e.dateTimeInit.isEmpty);

          game.idTeam1 = idTeam1;
          game.idTeam2 = idTeam2;

          await dao.updateItem(game);

          final teamList = await teamDao.getAll();
          for (var element in teamList) {
            element.gol = 0;
            await teamDao.updateItem(element);
          }
          return await getGameAndTeams();
        }

      } else {
        return null;
      }

    } catch (e) {
      print("Error newGameData $e");
      return null;
    }
  }

  @override
  Future<List<Game>> getAllGame() async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database_raxa.db').build();
      final dao = database.gameDao;

      return await dao.getAll();
    } catch (e) {
      print("Error getAllGame $e");
      return [];
    }
  }

}