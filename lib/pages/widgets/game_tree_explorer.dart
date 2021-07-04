import 'package:chess/chess.dart';
import 'package:chesstable/policy/game_tree.dart';
import 'package:flutter/material.dart';

class GameTreeExplorer extends StatelessWidget {
  final List<Chess> _chessGames;
  final GameTree _gameTree;

  GameTreeExplorer({required chessGames})
      : this._chessGames = chessGames,
        this._gameTree = GameTree().create(chessGames);

  @override
  Widget build(BuildContext context) {
    return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _gameTree.tree.keys
          .map((key) => Container(color: Colors.red, child: Text(key)))
          .toList(),
    );
  }
}
