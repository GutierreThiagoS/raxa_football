
import 'package:football/domain/models_entity/player_soccer.dart';

class PlayerSoccerSelectedTeam {
  PlayerSoccer player;
  int teamId;

  PlayerSoccerSelectedTeam({required this.player, required this.teamId});

  @override
  String toString() {
    return "PlayerSoccer $player, teamId $teamId";
  }
}