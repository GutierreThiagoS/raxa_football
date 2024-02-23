
import 'package:floor/floor.dart';

@entity
class PlayerInTeam {
  @PrimaryKey(autoGenerate: true)
  int? id;
  int gameId;
  int playerId;
  int teamId;
  int gol;

  PlayerInTeam({this.id, required this.gameId, required this.playerId, required this.teamId, this.gol = 0});

  @override
  String toString() {
    return "  PlayerInTeam({id: $id, gameId: $gameId, playerId: $playerId, teamId: $teamId, gol: $gol})";
  }
}