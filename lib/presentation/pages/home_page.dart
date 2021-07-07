import 'package:chess/chess.dart' hide State;
import 'package:chesstable/data/repositories/games_repository_hive.dart';
import 'package:chesstable/domain/use_cases/policy/game_tree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart';

import '../../domain/entities/half_move.dart';
import 'widgets/game_tree_explorer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var chess = Chess();
  late final GameTree gameTree;

  final List<Chess> chessGames = [];

  @override
  void initState() {
    GamesRepositoryImpl()
        .getAll()
        .then((eitherGames) => eitherGames.forEach((game) {
              final chessGame = Chess();
              chessGame.load_pgn(game);
              chessGames.add(chessGame);
            }));

    super.initState();
  }

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
                  onPressed: () async {
                    await Navigator.pushNamed(context, '/donwload');
                    final games = await GamesRepositoryImpl().getGames();
                    final loadedGame = games.toOption().toNullable()!;
                    //chess = Chess()..load_pgn(loadedGame);
                    gameTree = GameTree().create(this.chessGames);
                    setState(() {});
                  }),
            ],
          ),
        ),
      );

  final moves = [];

  Center _buildBody() => Center(
        child: Row(children: [
          Column(children: [
            Chessboard(
                boardSize: 600,
                fen: chess.generate_fen(),
                onMove: (move) {
                  chess.move({
                    'from': move.from,
                    'to': move.to,
                  });
                  setState(() {});
                }),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  child: Text('undo'),
                  onPressed: () {
                    moves.add(chess.undo_move());
                    setState(() {});
                  }),
              ElevatedButton(
                  child: Text('do'),
                  onPressed: () {
                    chess.move(moves.removeLast());
                    setState(() {});
                  }),
            ]),
          ]),
          GameTreeExplorer(
              gameTree: this.gameTree,
              onClick: (HalfMove half) {
                chess.move(half.position);
                moves.add(half.position);
                print(half.position);
                print(chess.generate_fen());
                Future.delayed(Duration(milliseconds: 500), () {
                  setState(() {});
                });
              }),
        ]),
      );
}
