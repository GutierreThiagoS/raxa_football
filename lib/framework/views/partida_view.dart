
import 'package:flutter/material.dart';
import 'package:football/framework/components/list_football_player.dart';

class PartidaView extends StatefulWidget {
  const PartidaView({super.key});

  @override
  State<PartidaView> createState() => _PartidaViewState();
}

class _PartidaViewState extends State<PartidaView> {

  List<String> jogadoresTime1 = ["Jogador 1", "Jogador 2", "Jogador 3", "Jogador 4", "Jogador 5"];
  List<String> jogadoresTime2 = ["Jogador 1", "Jogador 2", "Jogador 3", "Jogador 4"];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            color: Colors.black12,
            padding: EdgeInsets.only(top: 30, bottom: 20, left: 10, right: 10),
            child: Row(
              children: [
                Expanded(child: Image.asset("assets/camisa_ce.png")),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 20,),
                          Text("1",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Container(
                              child: Image.asset("assets/bolaf.png", height: 50),
                            padding: EdgeInsets.all(8),
                          ),
                          Text("0",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(child: Image.asset("assets/camisa_verde.png")),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ListFootballPlayer(
                    title: "Time 1",
                    players: jogadoresTime1
                ),
              ),
              Expanded(
                child: ListFootballPlayer(
                  title: "Time 2",
                    players: jogadoresTime2
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
