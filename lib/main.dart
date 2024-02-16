import 'package:flutter/material.dart';
import 'package:football/framework/views/create_football_player/create_football_player_view.dart';
import 'package:football/framework/views/include_player_team/include_player_in_team_view.dart';
import 'package:football/framework/views/menu_view.dart';
import 'package:football/framework/views/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raxa TI J.Sleiman',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (_) => SplashView(),
        "/principal": (_) => MenuView(),
        "/incluirJogador": (_) => IncludePlayerInTeamView(),
        "/criarJogador": (_) => CreateFootballPlayerView(),
      },
    );
  }
}