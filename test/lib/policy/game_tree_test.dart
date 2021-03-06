import 'package:chess/chess.dart';
import 'package:chesstable/domain/entities/half_move.dart';
import 'package:chesstable/domain/use_cases/policy/game_tree.dart';
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

      expect(gameTree.tree, equals({'e4': HalfMoveWithDescendency('e4', 1)}));
    });

    test('should create a basic position with two move', () {
      final chess = Chess();
      chess.move('e4');
      chess.move('e5');

      gameTree.create([chess]);

      expect(
          gameTree.tree,
          equals({
            'e4': HalfMoveWithDescendency('e4', 1, {
              'e5': HalfMoveWithDescendency('e5', 1),
            })
          }));
    });

    test('should create a basic position with one move and two games', () {
      final chess = Chess();
      chess.move('e4');

      final chess2 = Chess();
      chess2.move('e4');

      gameTree.create([chess, chess2]);

      expect(gameTree.tree, equals({'e4': HalfMoveWithDescendency('e4', 2)}));
    });

    test('should create a basic position with three moves and two games', () {
      final chess = Chess();
      chess.move('e4');
      chess.move('e5');
      chess.move('d4');

      final chess2 = Chess();
      chess2.move('e4');
      chess2.move('e5');
      chess2.move('Nf3');

      gameTree.create([chess, chess2]);

      expect(
          gameTree.tree,
          equals({
            'e4': HalfMoveWithDescendency('e4', 2, {
              'e5': HalfMoveWithDescendency('e5', 2, {
                'd4': HalfMoveWithDescendency('d4'),
                'Nf3': HalfMoveWithDescendency('Nf3')
              }),
            })
          }));
    });
  });
}
