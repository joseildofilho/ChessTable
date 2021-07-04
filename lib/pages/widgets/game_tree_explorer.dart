import 'package:chess/chess.dart' hide Color;
import 'package:chesstable/domain/entities/half_move.dart';
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
      children: _gameTree.tree.values
          .map((key) => HalfMoveStatsWidget(stat: key))
          .map((widget) => Padding(child: widget, padding: EdgeInsets.all(4.0)))
          .toList(),
    );
  }
}

class HalfMoveStatsWidget extends StatelessWidget {
  final HalfMoveStat stat;
  final double _barSize = 300;
  final double borderWidth = 2.3;

  const HalfMoveStatsWidget({required this.stat});

  @override
  Widget build(BuildContext context) => Container(
        width: _barSize + 35,
        child: Row(children: [
          Expanded(child: Text(stat.position)),
          Container(
            decoration: BoxDecoration(
                border:
                    Border.all(width: borderWidth, color: Colors.grey.shade300),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            width: _barSize + borderWidth * 2,
            child: Row(children: [
              Portion(
                width: _portion(this.stat.whiteWins),
                color: Colors.white,
                percent: calculatePercentage(this.stat.whiteWins),
              ),
              Portion(
                width: _portion(this.stat.draw),
                color: Colors.grey,
                percent: calculatePercentage(this.stat.draw),
              ),
              Portion(
                  width: _portion(this.stat.blackWins),
                  percent: calculatePercentage(stat.blackWins),
                  color: Colors.black),
            ]),
          ),
        ]),
      );

  double _portion(int game) => this._barSize * (game / this.stat.total);

  double calculatePercentage(int games) => games / this.stat.total;
}

class Portion extends StatelessWidget {
  final double width;
  final double percent;
  final Color color;

  const Portion(
      {required this.width, required this.percent, required this.color});

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: 20,
        color: color,
        child: Center(
          child: Text(this.percent.toStringAsFixed(2),
              style: TextStyle(
                color: this.color.computeLuminance() > 0.5
                    ? Colors.black
                    : Colors.white,
              )),
        ),
      );
}
