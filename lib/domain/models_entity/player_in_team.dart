
import 'package:floor/floor.dart';

@entity
class PlayerInTeam {
  @PrimaryKey(autoGenerate: true)
  int? id;
  int gameId;
  int playerId;
  String name;
  int teamId;
  int goals;

  PlayerInTeam({this.id, required this.gameId, required this.playerId, required this.name, required this.teamId, this.goals = 0});

  @override
  String toString() {
    return "  PlayerInTeam({id: $id, gameId: $gameId, playerId: $playerId, name: $name, teamId: $teamId, gol: $goals})";
  }
}