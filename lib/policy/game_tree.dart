import 'package:chess/chess.dart';
import 'package:equatable/equatable.dart';

class GameTree {
  Map<String, GameStateWithDescendency> tree = {};

  GameTree create(List<Chess> chessGames) {
    chessGames.forEach(
        (game) => updateTree(game.san_moves().map((x) => x!).toList()));
    return this;
  }

  updateTree(List<String> history) => history.fold<List<String>>(
        <String>[],
        (list, move) => move
            .split(' ')
            .skip(1)
            .fold<List<String>>(list, (l, halfMove) => l + [halfMove]),
      ).fold<Map<String, GameStateWithDescendency>>(
        tree,
        (subTree, halfMove) => subTree
            .update(
              halfMove,
              (state) => state.add1(),
              ifAbsent: () => GameStateWithDescendency(halfMove),
            )
            .descendency,
      );
}

class GameStateWithDescendency extends GameState {
  final int rechead;
  final Map<String, GameStateWithDescendency> descendency;

  GameStateWithDescendency(String position, [this.rechead = 1, descendency])
      : this.descendency = descendency ?? {},
        super(position);

  GameStateWithDescendency add1() => GameStateWithDescendency(
      this.position, this.rechead + 1, this.descendency);

  @override
  List<Object?> get props => [position, rechead, descendency];
}

class GameState extends Equatable {
  final String position;

  GameState(this.position);

  @override
  List<Object?> get props => [position];
}
