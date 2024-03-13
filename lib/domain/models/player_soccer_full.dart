
class PlayerSoccerFull {
  int id;
  String name;
  int level;
  bool presented;
  int goals;
  int gamesCount;
  int teamId;

  PlayerSoccerFull({required this.id, required this.name, required this.level, required this.presented, required this.goals, required this.gamesCount, required this.teamId});

  @override
  String toString() {
    return "PlayerSoccerFull({id: $id, name: $name, level: $level, presented $presented, goals $goals, gamesCount $gamesCount, teamId: $teamId})";
  }
}