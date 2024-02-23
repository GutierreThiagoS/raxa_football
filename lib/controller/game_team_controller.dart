
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:football/domain/models/game_and_teams.dart';
import 'package:football/domain/models/team_checkbox.dart';
import 'package:football/domain/models_entity/game.dart';
import 'package:football/domain/models_entity/player_soccer.dart';
import 'package:football/domain/models_entity/team.dart';
import 'package:football/domain/repository/game_repository.dart';
import 'package:football/domain/repository/player_in_team_repository.dart';

class GameTeamsController {

  final GameRepository _repository;
  final PlayerInTeamRepository _playerInTeamRepository;
  GameTeamsController(this._repository, this._playerInTeamRepository);

  var gameAndTeams = ValueNotifier<GameAndTeams?>(null);
  var timerGame = ValueNotifier<int>(10 * 60);

  Future<void> getGameData() async {
    gameAndTeams.value = await _repository.getGameAndTeams();
    timerGame.value = gameAndTeams.value?.game.minuteTimeGame??(10 * 60);
  }

  Future<List<Game>> getAllGame() async {
    return await _repository.getAllGame();
  }

  Future<void> initGame(Game game, bool isRefresh) async {
    if(isRefresh || game.dateTimeInit == "") {
      final initGame = await _repository.initGame(game);
      if (initGame != null) {
        gameAndTeams.value?.game = initGame;
      }
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
        notifyListeners();
      }
    } else {
      gameAndTeams.value?.teamAndPlayers2.team = team;
      final index = gameAndTeams.value?.teamAndPlayers2.players.indexWhere((element) => element.id == player.id);
      print("index2: $index");
      if (index != null && index != -1) {
        gameAndTeams.value?.teamAndPlayers2.players[index] = player;
        notifyListeners();
      }
    }
  }

  Future<List<Team>> getTeams() async {
    return await _repository.getTeams();
  }

  Future<void> newGameData(List<TeamCheckbox> list) async {
    timer?.cancel();
    gameAndTeams.value = await _repository.newGameData(list);
    timerGame.value = gameAndTeams.value?.game.minuteTimeGame??(10 * 60);
  }

  Future<void> savePlayerInTeam(int teamId, int playerId) async {
    await _playerInTeamRepository.savePlayerInTeam(teamId, playerId);
  }

  // ===================== TIMER =========================
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

  void notifyListeners() {
    gameAndTeams.notifyListeners();
  }

}