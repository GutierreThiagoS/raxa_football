
import 'package:floor/floor.dart';

@entity
class PlayerSoccer {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String name;
  int level;
  int gols;
  int partidas;
  int idTeam;

  PlayerSoccer({this.id, required this.name, this.level = 3, this.gols = 0, this.partidas = 0, this.idTeam = -1});

  @override
  String toString() {
    return "PlayerSoccer({id: $id, name: $name, level: $level, gols: $gols, partidas: $partidas, idTeam: $idTeam})";
  }
}