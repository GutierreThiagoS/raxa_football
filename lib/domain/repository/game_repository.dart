
import 'package:football/domain/models/game_and_teams.dart';
import 'package:football/domain/models/team_checkbox.dart';
import 'package:football/domain/models_entity/game.dart';
import 'package:football/domain/models_entity/player_soccer.dart';
import 'package:football/domain/models_entity/team.dart';

abstract class GameRepository {

  Future<Game?> getGameData();

  Future<GameAndTeams?> getGameAndTeams();

  Future<Game?> initGame(Game game);

  Future<void> getPlayerSoccer();

  Future<void> registerGolGame(Team team, PlayerSoccer playerSoccer);

  Future<List<Team>> getTeams();

  Future<GameAndTeams?> newGameData(List<TeamCheckbox> list);

  Future<List<Game>> getAllGame();
}