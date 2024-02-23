
import 'package:football/domain/models_entity/player_soccer.dart';

abstract class PlayerInTeamRepository {

  Future<PlayerSoccer?> savePlayerInTeam(int teamId, int playerId);

}