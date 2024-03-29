
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:football/data/local/dao/configuration_dao.dart';
import 'package:football/data/local/dao/game_dao.dart';
import 'package:football/data/local/dao/player_in_team_dao.dart';
import 'package:football/data/local/dao/player_soccer_dao.dart';
import 'package:football/data/local/dao/team_dao.dart';
import 'package:football/domain/models_entity/configuration.dart';
import 'package:football/domain/models_entity/player_in_team.dart';
import 'package:football/domain/models_entity/player_soccer.dart';
import 'package:football/domain/models_entity/team.dart';
import 'package:football/domain/models_entity/game.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(
    version: 1,
    entities: [
      Configuration,
      PlayerSoccer,
      Team,
      Game,
      PlayerInTeam
    ]
)
abstract class AppDatabase extends FloorDatabase {

  final StreamController<String> _changeListener = StreamController<String>.broadcast();

  Stream<String> get changeListenerStr => _changeListener.stream;

  TeamDao get teamDao;
  PlayerSoccerDao get playerSoccerDao;
  GameDao get gameDao;
  PlayerInTeamDao get playerInTeamDao;
  ConfigurationDao get configurationDao;
}