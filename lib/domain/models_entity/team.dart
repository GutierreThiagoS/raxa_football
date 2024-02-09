
import 'package:floor/floor.dart';

@entity
class Team {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String name;
  String image;

  Team({this.id, required this.name, required this.image});
}