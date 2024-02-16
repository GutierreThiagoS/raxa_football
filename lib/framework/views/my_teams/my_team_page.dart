import 'package:flutter/material.dart';
import 'package:football/controller/my_team_controller.dart';
import 'package:football/data/repository/team_repository_impl.dart';
import 'package:football/framework/views/my_teams/item_team.dart';

class MyTeamsPage extends StatefulWidget {
  const MyTeamsPage({super.key});

  @override
  State<MyTeamsPage> createState() => _MyTeamsPageState();
}

class _MyTeamsPageState extends State<MyTeamsPage> {

  final controller = MyTeamController(TeamRepositoryImpl());

  @override
  void initState() {
    super.initState();
    controller.getTeamList();
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
            child: Text("Times",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.white
              ),

            ),
          ),
          SizedBox(height: 10),
          ValueListenableBuilder(
            valueListenable: controller.teamList,
            builder:(context, value, child) => ListView.separated(
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return ItemTeam(team: value[index], saveTeam: (value) {
                    controller.saveTeam(value, index);
                  });
                },
                separatorBuilder: (_, __) => const Divider(),
                itemCount: value.length
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(onPressed: () {

          }, child: Text("NOVO"))
        ],
      ),
    );
  }
}
