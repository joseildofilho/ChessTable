import 'package:chesstable/home_page.dart';
import 'package:flutter/material.dart';

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
        title: 'ChessTable',
        theme: ThemeData.dark(),
        home: HomePage(),
      );
}

