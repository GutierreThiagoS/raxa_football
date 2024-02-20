
import 'package:floor/floor.dart';

@entity
class Game {
  @PrimaryKey(autoGenerate: true)
  int? id;
  int idTeam1;
  int idTeam2;
  String dateTimeInit;
  String dateTimeFinish;
  String dateTimeCreated;
  int minuteTimeGame;
  int time;
  int maxTime;
  bool initGame;
  bool finished;

  Game({
    this.id,
    required this.idTeam1,
    required this.idTeam2,
    this.dateTimeInit = "",
    this.dateTimeFinish = "",
    this.minuteTimeGame = 10 * 60,
    this.time = 1,
    this.maxTime = 2,
    required this.dateTimeCreated,
    this.initGame = false,
    this.finished = false,
  });

  @override
  String toString() {
    return "Game({ id: $id, idTeam1: $idTeam1, idTeam2: $idTeam2, "
        "dateTimeInit: $dateTimeInit, dateTimeFinish: $dateTimeFinish, "
        "tempoPartida $minuteTimeGame, tempo $time, quantidadeTempo $maxTime"
        "dateTimeCreated: $dateTimeCreated, isGame: $initGame, finished: $finished "
        "})";
  }
}