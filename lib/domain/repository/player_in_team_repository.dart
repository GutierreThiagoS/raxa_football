
import 'package:football/domain/models_entity/player_in_team.dart';
import 'package:football/domain/models_entity/player_soccer.dart';
import 'package:football/domain/models_entity/team.dart';

abstract class PlayerInTeamRepository {

  Future<PlayerInTeam?> savePlayerInTeam(int teamId, int playerId);

  Future<Team?> getTeamInPlayer(int playerId);

  Future<int> getTotalGoals(PlayerSoccer playerSoccer);

  Future<int> getTotalGames(PlayerSoccer playerSoccer);

  Future<PlayerInTeam?> removerPlayerInTeam(PlayerInTeam playerSoccer);

}