
import 'package:floor/floor.dart';

@entity
class Team {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String name;
  String image;

  Team({
    this.id,
    required this.name,
    this.image = "assets/team/camisa_ce.png",
  });

  @override
  String toString() {
    return "Team({id: $id, name: $name, image: $image})";
  }
}