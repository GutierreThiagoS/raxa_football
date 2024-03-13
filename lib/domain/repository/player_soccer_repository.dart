
import 'package:football/domain/models/player_soccer_full.dart';
import 'package:football/domain/models_entity/player_soccer.dart';

abstract class PlayerSoccerRepository {

  Future<List<PlayerSoccer>> getAllPlayerSoccer();

  Future<List<PlayerSoccerFull>> getAllPlayerSoccerFull();

  Future<PlayerSoccer?> savePlayerSoccer(PlayerSoccer item);

  Future<PlayerSoccerFull?> savePlayerSoccerFull(PlayerSoccerFull item);

  Future<List<PlayerSoccer>> getAllPlayerSoccerNotTeam();

  Future<PlayerSoccer?> removerPlayerInTeam(PlayerSoccer playerSoccer);
}