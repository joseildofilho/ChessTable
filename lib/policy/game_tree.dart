import 'package:chess/chess.dart';
import 'package:chesstable/domain/entities/half_move.dart';

class GameTree {
  Map<String, HalfMoveWithDescendency> tree = {};

  GameTree create(List<Chess> chessGames) {
    chessGames.forEach((Chess game) => updateTree(
        game.san_moves().map((x) => x!).toList(),
        _winner(game.header['Result'])));
    return this;
  }

  updateTree(List<String> history, GameResult result) {
    return history.fold<List<String>>(
      <String>[],
      (list, move) => move
          .split(' ')
          .skip(1)
          .fold<List<String>>(list, (l, halfMove) => l + [halfMove]),
    ).fold<Map<String, HalfMoveWithDescendency>>(
      tree,
      (subTree, String halfMove) => subTree
          .update(
            halfMove,
            (state) => AddMove.updateWithGameResult(result, state),
            ifAbsent: () => AddMove.updateWithGameResult(
                result,
                HalfMoveWithDescendency.withStat(
                    stat: HalfMoveStat(position: halfMove))),
          )
          .descendency,
    );
  }
}

class AddMove {
  static HalfMoveWithDescendency updateWithGameResult(
      GameResult gameResult, HalfMoveWithDescendency halfMove) {
    switch (gameResult) {
      case GameResult.BLACK_WIN:
        return addBlackWin(halfMove);
      case GameResult.WHITE_WIN:
        return addWhiteWin(halfMove);
      case GameResult.DRAW:
        return addDraw(halfMove);
      case GameResult.ONGOING:
        throw 'ongoing game';
    }
  }

  static HalfMoveWithDescendency addBlackWin(
          HalfMoveWithDescendency halfMove) =>
      halfMove.copyWith(blackWins: halfMove.blackWins + 1);

  static HalfMoveWithDescendency addWhiteWin(
          HalfMoveWithDescendency halfMove) =>
      halfMove.copyWith(whiteWins: halfMove.whiteWins + 1);

  static HalfMoveWithDescendency addDraw(HalfMoveWithDescendency halfMove) =>
      halfMove.copyWith(draw: halfMove.draw + 1);
}

GameResult _winner(String result) {
  if (result == '*') return GameResult.ONGOING;
  if (result == '1-0')
    return GameResult.WHITE_WIN;
  else if (result == '0-1')
    return GameResult.BLACK_WIN;
  else
    return GameResult.DRAW;
}

enum GameResult { BLACK_WIN, WHITE_WIN, DRAW, ONGOING }
