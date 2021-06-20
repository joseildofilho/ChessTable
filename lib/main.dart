import 'package:flutter/material.dart';

import 'download_games_page.dart';
import 'home_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  Hive.init('./');
  await Hive.openBox('games');
  runApp(ChessTable());
}

class ChessTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
          title: 'ChessTable',
          theme: ThemeData.dark(),
          initialRoute: '/',
          routes: {
            '/': (ctx) => HomePage(),
            '/donwload': (ctx) => DownloadGamesPage()
          });
}
