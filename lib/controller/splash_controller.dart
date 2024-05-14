
import 'package:football/domain/repository/game_repository.dart';
import 'package:football/domain/repository/team_repository.dart';

class SplashController {

  final GameRepository _gameRepository;
  final TeamRepository _teamRepository;

  SplashController(this._gameRepository, this._teamRepository);

  Future<void> syncData() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    await _teamRepository.getAllTeam();
    await _gameRepository.getPlayerSoccer();
    await _gameRepository.getGameData();
  }

}