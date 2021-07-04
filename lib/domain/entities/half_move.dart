import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'half_move.g.dart';

@CopyWith()
class HalfMoveWithDescendency extends HalfMoveStat {
  final int rechead;
  final Map<String, HalfMoveWithDescendency> descendency;

  HalfMoveWithDescendency({
    this.rechead = 1,
    descendency,
    required String position,
    required int whiteWins,
    required int draw,
    required int blackWins,
  })  : this.descendency = descendency ?? {},
        super(
          position: position,
          whiteWins: whiteWins,
          draw: draw,
          blackWins: blackWins,
        );

  HalfMoveWithDescendency.withStat({
    int rechead = 1,
    descendency,
    required HalfMoveStat stat,
  }) : this(
            rechead: rechead,
            descendency: descendency,
            position: stat.position,
            whiteWins: stat.whiteWins,
            blackWins: stat.blackWins,
            draw: stat.draw);

  @override
  List<Object?> get props => [rechead, descendency, ...super.props];
}

@CopyWith()
class HalfMoveStat extends HalfMove {
  final int whiteWins, draw, blackWins, total;

  HalfMoveStat({
    required String position,
    this.whiteWins = 0,
    this.draw = 0,
    this.blackWins = 0,
  })  : total = whiteWins + draw + blackWins,
        super(position);

  @override
  List<Object?> get props => [whiteWins, draw, blackWins, ...super.props];
}

class HalfMove extends Equatable {
  final String position;

  HalfMove(this.position);

  @override
  List<Object?> get props => [position];
}
