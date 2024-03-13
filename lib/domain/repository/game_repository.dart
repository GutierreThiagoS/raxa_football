
import 'package:football/domain/models/game_and_teams.dart';
import 'package:football/domain/models/team_and_players.dart';
import 'package:football/domain/models/team_checkbox.dart';
import 'package:football/domain/models_entity/game.dart';
import 'package:football/domain/models_entity/player_in_team.dart';
import 'package:football/domain/models_entity/team.dart';

abstract class GameRepository {

  Future<Game?> getGameData();

  Future<GameAndTeams?> getGameAndTeams();

  Future<Game?> initGame(Game game);

  Future<void> getPlayerSoccer();

  Future<void> registerGolGame(PlayerInTeam playerInTeam);

  Future<List<Team>> getTeams();

  Future<List<TeamAndPlayers>> getTeamsInGame(int idGame);

  Future<GameAndTeams?> newGameData(List<TeamCheckbox> list);

  Future<List<Game>> getAllGame();
}