import 'package:chess/chess.dart' hide State;
import 'package:flutter/material.dart';
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final chess = Chess();
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('ChessTable')),
        body: _buildBody(),
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                  child: Center(child: Text('Should be a pawn image'))),
              TextButton(
                  child: ListTile(title: Text('Load Games')),
                  onPressed: () {
                    Navigator.pushNamed(context, '/donwload');
                  }),
            ],
          ),
        ),
      );

  Center _buildBody() => Center(
        child: Chessboard(
            boardSize: 600,
            fen: chess.generate_fen(),
            onMove: (move) {
              chess.move({
                'from': move.from,
                'to': move.to,
              });
              setState(() {});
            }),
      );
}
