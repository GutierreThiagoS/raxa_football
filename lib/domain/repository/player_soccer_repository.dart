
import 'package:football/domain/models_entity/player_soccer.dart';

abstract class PlayerSoccerRepository {

  Future<List<PlayerSoccer>> getAllPlayerSoccer();

  Future<PlayerSoccer?> savePlayerSoccer(PlayerSoccer item);

  Future<List<PlayerSoccer>> getAllPlayerSoccerNotTeam();

  Future<PlayerSoccer?> removerPlayerInTeam(PlayerSoccer playerSoccer);
}