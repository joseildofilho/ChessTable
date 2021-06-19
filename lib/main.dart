import 'package:chess/chess.dart' hide State;
import 'package:flutter/material.dart';
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart';

void main() {
  runApp(ChessTable());
}

class ChessTable extends StatefulWidget {
  @override
  _ChessTableState createState() => _ChessTableState();
}

class _ChessTableState extends State<ChessTable> {
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final chess = Chess();
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
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
        ),
      );
}
