
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:football/domain/models/game_and_teams.dart';
import 'package:football/domain/models_entity/game.dart';
import 'package:football/domain/models_entity/player_soccer.dart';
import 'package:football/domain/models_entity/team.dart';
import 'package:football/domain/repository/game_repository.dart';

class GameTeamsController {

  final GameRepository _repository;
  GameTeamsController(this._repository);

  var gameAndTeams = ValueNotifier<GameAndTeams?>(null);
  var timerGame = ValueNotifier<int>(10 *  60);

  Future<void> getGameData() async {
    gameAndTeams.value = await _repository.getGameAndTeams();
    timerGame.value = (gameAndTeams.value?.game.minuteTimeGame??10)  *  60;
  }

  Future<void> initGame(Game game) async {
    final initGame = await _repository.initGame(game);
    if (initGame != null) {
      gameAndTeams.value?.game = initGame;
    }
  }

  Future<void> registerGolGame(Team team, PlayerSoccer player) async {
    team.gol ++;
    team.totalGolGames ++;
    player.gols ++;
    await _repository.registerGolGame(team, player);
    if(gameAndTeams.value?.teamAndPlayers1.team.id == team.id) {
      gameAndTeams.value?.teamAndPlayers1.team = team;
      final index = gameAndTeams.value?.teamAndPlayers1.players.indexWhere((element) => element.id == player.id);
      print("index: $index");

      if (index != null && index != -1) {
        gameAndTeams.value?.teamAndPlayers1.players[index] = player;
        gameAndTeams.notifyListeners();
      }
    } else {
      gameAndTeams.value?.teamAndPlayers2.team = team;
      final index = gameAndTeams.value?.teamAndPlayers2.players.indexWhere((element) => element.id == player.id);
      print("index2: $index");
      if (index != null && index != -1) {
        gameAndTeams.value?.teamAndPlayers2.players[index] = player;
        gameAndTeams.notifyListeners();
      }
    }
  }

  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(
      Duration(seconds:  1),
          (Timer timer) {
        if (timerGame.value ==  0) {
          timer.cancel();

        } else {
          timerGame.value --;
        }
      },
    );
  }

}