
import 'package:football/domain/models_entity/team.dart';

class TeamCheckbox {
  Team team;
  int checkedIndex;

  TeamCheckbox({ required this.team, required this.checkedIndex});

  @override
  String toString() {
    return "TeamCheckbox({team: $team, checkedIndex: $checkedIndex})";
  }
}