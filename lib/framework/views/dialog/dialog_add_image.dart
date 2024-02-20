import 'dart:convert';

import 'package:flutter/material.dart';

void showDialogAddImage(BuildContext context, List<String> valueImage, Function(String) saveImage) {

  Future<List<String>> findFiles(BuildContext context) async {
    var manifest =
    await DefaultAssetBundle.of(context).loadString('AssetManifest.json');

    Map map = jsonDecode(manifest);
    List<String> values = map.keys.where((k) => k.contains('assets/team')
        && !valueImage.contains(k)).toList() as List<String>;

    print("valueImage $valueImage map $map");
    return Future.value(values);
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Adicione a Imagem do Time"),
        scrollable: true,
        content: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.4,
          child: FutureBuilder(
            future: findFiles(context),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else if (snapshot.hasData && snapshot.data != null) {
                return GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(snapshot.data?.length??0, (index) {
                      return InkWell(
                        onTap: () {
                          if (snapshot.data?[index] != null) {
                            saveImage('${snapshot.data?[index]}');
                            Navigator.of(context).pop();
                          }
                        },
                          child: Ink(
                            padding: EdgeInsets.all(10),
                            child: Image.asset('${snapshot.data?[index]}',
                            ),
                          ));
                    })
                );
              } else {
                return const CircularProgressIndicator();
              }
            })
          ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
        ],
      );
    },
  );
}
