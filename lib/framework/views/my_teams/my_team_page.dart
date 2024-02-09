import 'package:flutter/material.dart';
import 'package:football/framework/views/my_teams/item_team.dart';

class MyTeamsPage extends StatefulWidget {
  const MyTeamsPage({super.key});

  @override
  State<MyTeamsPage> createState() => _MyTeamsPageState();
}

class _MyTeamsPageState extends State<MyTeamsPage> {

  final list = ["time 1", "time 2"];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Text("Times",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.white
              ),

            ),
          ),
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return ItemTeam(label: list[index]);
              },
              separatorBuilder: (_, __) => const Divider(),
              itemCount: list.length
          )
        ],
      ),
    );
  }
}
