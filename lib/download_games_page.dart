import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:chesstable/services/lichess.dart';
import 'package:flutter/material.dart';

import 'core/progress.dart';
import 'download_games_forms_widget.dart';

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
              child: DownloadGamesForm(downloadGamesPage),
            )
          ],
        ),
      );
}

class DownloadGamesController {
  late StreamController<Progress<String>> _gamesDownloadProgress =
      StreamController()..sink.add(Initial());

  Stream<Progress<String>> get games => this._gamesDownloadProgress.stream;

  final Set<String> _games = {};

  int get numberOfGames => _games.length;

  void startDownload(String playersName) async {
    final Stream<String> data = await getAllGamesFrom(playersName);
    _gamesDownloadProgress.sink.addStream(data
        .doOnData(_games.add)
        .doOnData(print)
        .map<Progress<String>>((s) => ProcessingPartialResult(data: s))
        .endWith(Done(data: '')));
  }

  dispose() {
    _gamesDownloadProgress.close();
  }
}
