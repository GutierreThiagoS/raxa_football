
import 'package:floor/floor.dart';

@entity
class Team {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String name;
  String image;
  int gol;
  int totalGolGames;

  Team({
    this.id,
    required this.name,
    this.image = "assets/team/camisa_ce.png",
    this.gol = 0,
    this.totalGolGames = 0
  });

  @override
  String toString() {
    return "Team({id: $id, name: $name, image: $image, gol: $gol, totalGolGames: $totalGolGames})";
  }
}