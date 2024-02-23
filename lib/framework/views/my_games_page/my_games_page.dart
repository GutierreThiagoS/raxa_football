import 'package:flutter/material.dart';
import 'package:football/controller/game_team_controller.dart';
import 'package:football/data/repository/game_repository_impl.dart';
import 'package:football/data/repository/player_in_team_repository_impl.dart';
import 'package:football/domain/models_entity/game.dart';
import 'package:football/framework/views/my_games_page/item_game_view_holder.dart';

class MyGamesPage extends StatefulWidget {
  const MyGamesPage({super.key});

  @override
  State<MyGamesPage> createState() => _MyGamesPageState();
}

class _MyGamesPageState extends State<MyGamesPage> {

  final controller = GameTeamsController(GameRepositoryImpl(), PlayerInTeamRepositoryImpl());

  var games = ValueNotifier<List<Game>>([]);

  @override
  void initState() {
    controller.getAllGame().then((value) => games.value = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Text("Jogos",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.white
              ),
            ),
          ),
          Expanded(
            child:  ValueListenableBuilder(
              valueListenable: games,
              builder:(_, list, __) => ListView.separated(
                  itemBuilder: (_, index) {
                    return ItemGameViewHolder(
                        game: list[index],
                      controller: controller,
                    );
                  },
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: list.length
              ),
            ),
          ),
        ],
      ),
    );
  }
}
