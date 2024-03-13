
import 'package:floor/floor.dart';

@entity
class Configuration {

  @PrimaryKey(autoGenerate: true)
  int id;
  int minuteTimerGame;
  int qtdPlayers;
  int time;
  int maxTime;

  Configuration({
    this.id = 1,
    this.minuteTimerGame = 10 * 60,
    this.qtdPlayers = 5,
    this.time = 1,
    this.maxTime = 2
  });

  @override
  String toString() {
    return "Configuration({id = $id, minuteTimerGame = $minuteTimerGame, time = $time, maxTime = $maxTime})";
  }
}