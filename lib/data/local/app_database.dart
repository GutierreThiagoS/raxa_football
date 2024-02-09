

import 'dart:async';

import 'package:floor/floor.dart';
import 'package:football/data/local/dao/player_soccer_dao.dart';
import 'package:football/data/local/dao/team_dao.dart';

abstract class AppDatabase extends FloorDatabase {

  final StreamController<String> _changeListener = StreamController<String>.broadcast();

  Stream<String> get changeListenerStr => _changeListener.stream;

  TeamDao get teamDao;
  PlayerSoccerDao get playerSoccerDao;
}