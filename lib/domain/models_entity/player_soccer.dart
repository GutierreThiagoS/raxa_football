
import 'package:floor/floor.dart';

class PlayerSoccer {
  @PrimaryKey(autoGenerate: true)
  int? id;

  String name;
  int level;
  int gols;
  int partidas;

  PlayerSoccer({this.id, required this.name, required this.level, required this.gols, required this.partidas});
}