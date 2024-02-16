import 'package:flutter/material.dart';
import 'package:football/framework/views/include_player_team/include_player_in_team.dart';

class IncludePlayerInTeamView extends StatefulWidget {
  const IncludePlayerInTeamView({super.key});

  @override
  State<IncludePlayerInTeamView> createState() => _IncludePlayerInTeamViewState();
}

class _IncludePlayerInTeamViewState extends State<IncludePlayerInTeamView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Incluir Jogador")),
      floatingActionButton: FloatingActionButton(
          onPressed: () {  },
          child: const Text("Novo")
      ),
      body: const IncludePlayerInTeam()
    );
  }
}