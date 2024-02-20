
import 'package:football/data/local/database.dart';
import 'package:football/domain/models/game_and_teams.dart';
import 'package:football/domain/models/team_and_players.dart';
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
      final game = await getGameData();

      if(game != null) {
        final teamDao = database.teamDao;
        final playerDao = database.playerSoccerDao;
        final teams = await teamDao.getTeamInGame([game.idTeam1, game.idTeam2]);

        if(teams.length > 1) {
          final teamFirst = teams.first;
          final teamSecond = teams[1];
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

}