
import 'package:football/domain/models_entity/player_soccer.dart';
import 'package:football/domain/models_entity/team.dart';

class TeamAndPlayers {
  Team team;
  List<PlayerSoccer> players;

  TeamAndPlayers({required this.team, required this.players});

  @override
  String toString() {
    return "TeamAndPlayers({team: $team, players: $players})";
  }
}