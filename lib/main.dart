import 'package:chesstable/services/lichess.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'download_games_forms_widget.dart';

void main() {
  runApp(ChessTable());
}

class ChessTable extends StatefulWidget {
  @override
  _ChessTableState createState() => _ChessTableState();
}

class _ChessTableState extends State<ChessTable> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'ChessTable',
        theme: ThemeData.dark(),
        home: DownloadGamesPage(),
      );
}

class DownloadGamesPage extends StatelessWidget {
  final DownloadGamesController downloadGamesPage = DownloadGamesController();

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('ChessTable'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: DownloadGamesForm(downloadGamesPage.games),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        downloadGamesPage.startDownload();
      }));
}

class DownloadGamesController {
  late StreamController<Progress<String>> _gamesDownloadProgress =
      StreamController()..sink.add(Initial());

  Stream<Progress<String>> get games => this._gamesDownloadProgress.stream;

  final Set<String> _games = {};

  void startDownload() async {
    final Stream<String> data = await getAllGamesFrom('joseildo');
    _gamesDownloadProgress.sink.addStream(data
        .map<Progress<String>>((s) => ProcessingPartialResult(data: s))
        .endWith(Done(data: '')));
  }

  dispose() {
    _gamesDownloadProgress.close();
  }
}

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
