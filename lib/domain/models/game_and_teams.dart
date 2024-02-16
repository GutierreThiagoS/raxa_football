
import 'package:football/domain/models/team_and_players.dart';
import 'package:football/domain/models_entity/game.dart';

class GameAndTeams {
  Game game;
  TeamAndPlayers teamAndPlayers1;
  TeamAndPlayers teamAndPlayers2;

  GameAndTeams({required this.game, required this.teamAndPlayers1, required this.teamAndPlayers2});

  @override
  String toString() {
    return "GameAndTeams({game: $game, teamAndPlayers1: $teamAndPlayers1, teamAndPlayers2: $teamAndPlayers2})";
  }
}