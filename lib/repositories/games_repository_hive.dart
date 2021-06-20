import 'package:chess/chess.dart';
import 'package:dartz/dartz.dart';

import 'package:chesstable/core/sucess.dart';

import 'package:chesstable/core/failure.dart';
import 'package:hive/hive.dart';

import 'games_repository.dart';

class GamesRepositoryImpl extends GamesRepository {
  static final box = Hive.box('games');
  static String lastGame = '';
  @override
  Future<Either<Failure, Success>> saveLocally(String game) {
    final chessgame = Chess()..load_pgn(game);
    lastGame = chessgame.header["Site"];
    box.put('$lastGame', game);
    return Future.value(Right(Success()));
  }

  Future<Either<Failure, String>> getGames() {
    return Future.value(Right(box.get(lastGame)));
  }
}