import 'package:flutter/material.dart';

import 'download_games_page.dart';
import 'home_page.dart';

void main() {
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
