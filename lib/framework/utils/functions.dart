

import 'package:football/domain/models/team_and_players.dart';

int sumByGoal(TeamAndPlayers team) {
  if (team.playerInTeams.isNotEmpty) {
    return team.playerInTeams.map((e) => e.goals)
        .reduce((value, element) => value + element);
  } else {
    return 0;
  }

}
