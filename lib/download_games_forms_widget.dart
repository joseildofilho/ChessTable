import 'package:chesstable/main.dart';
import 'package:flutter/material.dart';

class DownloadGamesForm extends StatefulWidget {
  DownloadGamesForm(this.gamesStream);

  final Stream<Progress<String>> gamesStream;

  @override
  _DownloadGamesFormState createState() => _DownloadGamesFormState();
}

class _DownloadGamesFormState extends State<DownloadGamesForm> {
  final Set<String> games = {};

  @override
  Widget build(BuildContext context) => StreamBuilder<Progress<String>>(
      stream: widget.gamesStream,
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (data is ProcessingPartialResult<String>) games.add(data.data);
        return Form(
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
                  onPressed: () async {},
                ),
                Text('${games.length}'),
                if (!(data is Done || data is Initial))
                  CircularProgressIndicator(),
              ],
            ),
          ),
        );
      });
}
