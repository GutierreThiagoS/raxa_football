import 'package:flutter/material.dart';
import 'package:football/framework/views/create_football_player/create_football_player.dart';
import 'package:football/framework/views/include_player_team/include_player_in_team.dart';
import 'package:football/framework/views/my_teams/my_team_page.dart';
import 'package:football/framework/views/partida_view.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
   ValueNotifier<int> indexCurrent = ValueNotifier<int>(0);

  final page = [
    const PartidaView(),
    const IncludePlayerInTeam(),
    const CreateFootballPlayer(),
    const MyTeamsPage(),
  ];

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Raxa TI J.Sleiman'),
      ),
      drawer: ValueListenableBuilder<int>(
        valueListenable: indexCurrent,
        builder: (_, i, __) {
          return NavigationDrawer(
            children: [
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
                  icon: Icon(Icons.person_add_alt_1_rounded),
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
            ],
            onDestinationSelected: (i) {
              indexCurrent.value = i;
              Navigator.pop(context);
            },
            selectedIndex: i,
          );
        }
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: indexCurrent,
        builder: (_, i, __) => page[i]
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.h_plus_mobiledata_sharp),
        onPressed: () {

        },
      ),
    );
  }
}
