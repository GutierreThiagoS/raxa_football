import 'package:flutter/material.dart';
import 'package:football/controller/include_player_team_controller.dart';
import 'package:football/framework/views/create_football_player/create_football_player.dart';

class CreateFootballPlayerView extends StatefulWidget {
  const CreateFootballPlayerView({super.key});

  @override
  State<CreateFootballPlayerView> createState() => _CreateFootballPlayerViewState();
}

class _CreateFootballPlayerViewState extends State<CreateFootballPlayerView> {

  final controller = IncludePlayerTeamController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Criar Jogador")),
      floatingActionButton: FloatingActionButton(
          onPressed: () {  },
          child: Text("Novo")
      ),
      body: CreateFootballPlayer()
    );
  }
}