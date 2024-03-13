
import 'package:floor/floor.dart';

@entity
class PlayerSoccer {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String name;
  int level;
  bool presented;

  PlayerSoccer({this.id, required this.name, this.level = 3, this.presented = true});

  @override
  String toString() {
    return "PlayerSoccer({id: $id, name: $name, level: $level, presented: $presented})";
  }
}