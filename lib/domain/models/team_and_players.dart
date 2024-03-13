
import 'package:football/domain/models_entity/player_in_team.dart';
import 'package:football/domain/models_entity/team.dart';

class TeamAndPlayers {
  Team team;
  List<PlayerInTeam> playerInTeams;

  TeamAndPlayers({required this.team, required this.playerInTeams});

  @override
  String toString() {
    return "TeamAndPlayers({team: $team, players: $playerInTeams})";
  }
}