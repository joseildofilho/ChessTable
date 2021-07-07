import 'package:chesstable/core/failure.dart';
import 'package:chesstable/core/sucess.dart';
import 'package:dartz/dartz.dart';

abstract class GamesRepository {
  Future<Either<Failure, Success>> saveLocally(String game);
}
