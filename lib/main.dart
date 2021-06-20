import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'dart:async';

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
            child: StreamBuilder(
              stream: downloadGamesPage.games,
              builder: (BuildContext context,
                  AsyncSnapshot<Progress<String>> snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data;
                  if (data is Initial)
                    return DownloadGamesForm();
                  else if (data is Processing)
                    return Center(child: CircularProgressIndicator());
                  else
                    return Container(
                        height: 300, width: 300, color: Colors.red);
                }
                return Container();
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        downloadGamesPage.startDownload();
      }));
}

class DownloadGamesForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Form(
        child: Container(
          width: 200,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Player's Name",
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: Text("Get Games"),
                onPressed: () {},
              ),
            ],
          ),
        ),
      );
}

class DownloadGamesController {
  late StreamController<Progress<String>> _gamesDownloadProgress =
      StreamController()..sink.add(Initial());

  Stream<Progress<String>> get games => this._gamesDownloadProgress.stream;

  void startDownload() async {
    this._gamesDownloadProgress.sink.add(Processing());
    await Future.delayed(Duration(seconds: 10));
    this._gamesDownloadProgress.sink.add(Done(data: ''));
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
