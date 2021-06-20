import 'package:equatable/equatable.dart';

abstract class Progress<T> extends Equatable {}

class Initial<T> extends Progress<T> {
  @override
  List<Object?> get props => [];
}

class Processing<T> extends Progress<T> {
  @override
  List<Object?> get props => [];
}

class ProcessingPartialResult<T> extends Progress<T> {
  final T data;

  ProcessingPartialResult({required this.data});

  @override
  List<Object?> get props => [];
}

class Done<T> extends Progress<T> {
  final T data;

  Done({required this.data});

  @override
  List<Object?> get props => [data];
}

class Problem<T> extends Progress<T> {
  final String message;

  Problem({required this.message});

  @override
  List<Object?> get props => [message];
}
