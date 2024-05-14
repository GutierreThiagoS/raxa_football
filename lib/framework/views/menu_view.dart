import 'dart:math';

import 'package:flutter/material.dart';
import 'package:football/framework/views/create_football_player/create_football_player.dart';
import 'package:football/framework/views/include_player_team/include_player_in_team.dart';
import 'package:football/framework/views/my_games_page/my_games_page.dart';
import 'package:football/framework/views/my_teams/my_team_page.dart';
import 'package:football/framework/views/game_football/game_teams_view.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
   ValueNotifier<int> indexCurrent = ValueNotifier<int>(0);

   String randomBackground() {
     final list =[
       'assets/background_raxa.jpg',
       'assets/background_raxa2.jpg',
       'assets/background_raxa3.jpg',
       'assets/background_raxa4.jpg',
     ];

     final random = Random();
     final i = random.nextInt(list.length);

     return list[i];
   }

  final page = [
    const GameTeamsView(),
    const IncludePlayerInTeam(),
    const CreateFootballPlayer(),
    const MyTeamsPage(),
    const MyGamesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (pop) {
        print("Pop $pop");
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Raxa '),
        ),
        drawer: ValueListenableBuilder<int>(
          valueListenable: indexCurrent,
          builder: (_, i, __) {
            return NavigationDrawer(
              onDestinationSelected: (i) {
                indexCurrent.value = i;
                Navigator.pop(context);
              },
              selectedIndex: i,
              children: const [
                ListTile(
                  dense: true,
                  title: Text(
                    "Raxa",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                NavigationDrawerDestination(
                    icon: Icon(Icons.sports_soccer),
                    label: Text('Partida'),
                ),
                NavigationDrawerDestination(
                    icon: Icon(Icons.format_list_numbered),
                    label: Text('Jogadores')
                ),
                NavigationDrawerDestination(
                    icon: Icon(Icons.person_add_alt_1_rounded),
                    label: Text('Criar Jogador')
                ),
                NavigationDrawerDestination(
                    icon: Icon(Icons.sports_sharp),
                    label: Text('Meus Times'),
                ),
                NavigationDrawerDestination(
                  icon: Icon(Icons.format_list_bulleted_outlined),
                  label: Text('Meus Jogos'),
                ),
              ],
            );
          }
        ),
        body: ValueListenableBuilder<int>(
          valueListenable: indexCurrent,
          builder: (_, i, __) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(randomBackground()),
                  fit: BoxFit.cover,
                  opacity: 0.4
                ),
              ),
              child: page[i]
          )
        ),
      ),
    );
  }
}
