import 'package:chess/chess.dart';
import 'package:equatable/equatable.dart';

class GameTree {
  Map<String, GameStateWithDescendency> tree = {};

  create(List<Chess> chessGames) {
      final move = chessGames.first.history.first.move.toAlgebraic;
      tree[move] = GameStateWithDescendency(move, 1); 
  }
}

class GameStateWithDescendency extends GameState {
  final int rechead;
  final Map<String, GameStateWithDescendency> descendency;

  GameStateWithDescendency(String position, this.rechead,
      [this.descendency = const {}])
      : super(position);
}

class GameState extends Equatable {
  final String position;

  GameState(this.position);

  @override
  List<Object?> get props => [position];
}
