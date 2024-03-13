
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:football/domain/models/game_and_teams.dart';
import 'package:football/domain/models/team_and_players.dart';
import 'package:football/domain/models/team_checkbox.dart';
import 'package:football/domain/models_entity/game.dart';
import 'package:football/domain/models_entity/player_in_team.dart';
import 'package:football/domain/models_entity/team.dart';
import 'package:football/domain/repository/game_repository.dart';
import 'package:intl/intl.dart';

class GameTeamsController {

  final GameRepository _repository;
  GameTeamsController(this._repository);

  var gameAndTeams = ValueNotifier<GameAndTeams?>(null);
  var timerGame = ValueNotifier<int>(10 * 60);

  Future<void> getGameData() async {
    gameAndTeams.value = await _repository.getGameAndTeams();
    timerGame.value = gameAndTeams.value?.game.minuteTimeGame??(10 * 60);
  }

  Future<List<Game>> getAllGame() async {
    return await _repository.getAllGame();
  }

  Future<int> initGame(Game game, bool isRefresh) async {
    if(isRefresh || game.dateTimeInit == "") {
      final initGame = await _repository.initGame(game);
      if (initGame != null) {
        gameAndTeams.value?.game = initGame;
        return getTimerInGame(game.dateTimeInit, game.dateTimeFinish);
      } else {
        return getTimerInGame("", game.dateTimeFinish);
      }
    } else {
      return getTimerInGame("", game.dateTimeFinish);
    }
  }


  int getTimerInGame(String initialDateStr, String finalDateStr) {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
    var date = DateTime.now();

    if(initialDateStr.isNotEmpty) {
      date = dateFormat.parse(initialDateStr);
    }

    final finalDate = dateFormat.parse(finalDateStr);

    print("date $date ${date.second}");
    print("finalDate $finalDate ${finalDate.second}");

    if (date.isBefore(finalDate)) {
      final hour = finalDate.hour - date.hour;
      final minute = finalDate.minute - date.minute;
      final second = finalDate.second - date.second;
      final timers = (hour * 60 * 60) + (minute * 60) + second;
      print("hour $hour minute $minute second $second");
      print("timers $timers");
      if (timers > 0) {
        return timers;
      } else {
        return 0;
      }
    } else {
      return 0;
    }

  }

  Future<void> registerGolGame(PlayerInTeam playerInTeam) async {
    playerInTeam.goals ++;
    await _repository.registerGolGame(playerInTeam);
    if(gameAndTeams.value?.teamAndPlayers1.team.id == playerInTeam.teamId) {
      final index = gameAndTeams.value?.teamAndPlayers1.playerInTeams.indexWhere((element) => element.id == playerInTeam.id);
      print("index: $index");

      if (index != null && index != -1) {
        gameAndTeams.value?.teamAndPlayers1.playerInTeams[index] = playerInTeam;
        notifyListeners();
      }
    } else {
      final index = gameAndTeams.value?.teamAndPlayers2.playerInTeams.indexWhere((element) => element.id == playerInTeam.id);
      print("index2: $index");
      if (index != null && index != -1) {
        gameAndTeams.value?.teamAndPlayers2.playerInTeams[index] = playerInTeam;
        notifyListeners();
      }
    }
  }

  Future<List<Team>> getTeams() async {
    return await _repository.getTeams();
  }

  Future<List<TeamAndPlayers>> getTeamsInGame(int idGame) async {
    return await _repository.getTeamsInGame(idGame);
  }

  Future<void> newGameData(List<TeamCheckbox> list) async {
    timer?.cancel();
    gameAndTeams.value = await _repository.newGameData(list);
    timerGame.value = gameAndTeams.value?.game.minuteTimeGame??(10 * 60);
  }

  // ===================== TIMER =========================
  Timer? timer;

  void startTimer(int timers) {
    timerGame.value = timers;
    if (timer == null || timer?.isActive == false) {
      timer = Timer.periodic(
        Duration(seconds: 1),
            (Timer timer) {
          if (timerGame.value == 0) {
            timer.cancel();
          } else {
            timerGame.value --;
          }
        },
      );
    }
  }

  void notifyListeners() {
    gameAndTeams.notifyListeners();
  }

}