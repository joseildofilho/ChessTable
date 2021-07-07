import 'package:chesstable/domain/entities/half_move.dart';
import 'package:chesstable/domain/use_cases/policy/game_tree.dart';
import 'package:flutter/material.dart';

class GameTreeExplorer extends StatefulWidget {
  final GameTree gameTree;
  final Function(HalfMove stat) onClick;

  GameTreeExplorer({required this.gameTree, required this.onClick});

  @override
  _GameTreeExplorerState createState() => _GameTreeExplorerState();
}

class _GameTreeExplorerState extends State<GameTreeExplorer> {
  @override
  Widget build(BuildContext context) => Column(
        children: widget.gameTree.tree.values
            .map((key) => HalfMoveStatsWidget(stat: key))
            .map((widget) => InkWell(
                  child: widget,
                  onTap: () {
                    this.widget.gameTree.goDown(widget.stat.position);
                    this.widget.onClick(widget.stat);
                    setState(() {});
                  },
                ))
            .map((widget) => Padding(
                  child: widget,
                  padding: EdgeInsets.all(4.0),
                ))
            .toList(),
      );
}

class HalfMoveStatsWidget extends StatelessWidget {
  final HalfMoveStat stat;
  final double _barSize = 300;
  final double borderWidth = 2.3;

  const HalfMoveStatsWidget({required this.stat});

  @override
  Widget build(BuildContext context) => Container(
        width: _barSize + 35,
        child: InkWell(
          child: Row(children: [
            Expanded(child: Text(stat.position)),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      width: borderWidth, color: Colors.grey.shade300),
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
        ),
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
