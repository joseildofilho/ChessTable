import 'package:chess/chess.dart';
import 'package:chesstable/policy/game_tree.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  late GameTree gameTree;

  setUp(() {
    gameTree = GameTree();
  });

  group('GameTree', () {
    test('should create a basic position with one move', () {
      final chess = Chess();
      chess.move('e4');

      gameTree.create([chess]);

      expect(gameTree.tree, equals({'e4': GameStateWithDescendency('e4', 1)}));
    });
  });
}
