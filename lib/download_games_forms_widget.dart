import 'package:flutter/material.dart';

import 'core/progress.dart';
import 'download_games_page.dart';

class DownloadGamesForm extends StatefulWidget {
  DownloadGamesForm(this.gamesStream);

  final DownloadGamesController gamesStream;
  final TextEditingController playersName = TextEditingController();

  @override
  _DownloadGamesFormState createState() => _DownloadGamesFormState();
}

class _DownloadGamesFormState extends State<DownloadGamesForm> {
  @override
  Widget build(BuildContext context) => StreamBuilder<Progress<String>>(
        stream: widget.gamesStream.games,
        builder: (context, snapshot) => Form(
          child: Container(
            width: 200,
            child: Column(
              children: [
                TextFormField(
                    controller: widget.playersName,
                    decoration: InputDecoration(
                      labelText: "Player's Name",
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      if (v != null && v.isNotEmpty) {
                        return '';
                      }
                      return 'type the player name';
                    }),
                SizedBox(height: 10),
                ElevatedButton(
                  child: Text("Get Games"),
                  onPressed: () {
                    final playerName = widget.playersName.text;
                    if (playerName.isNotEmpty)
                      widget.gamesStream.startDownload(playerName);
                  },
                ),
                Text('${widget.gamesStream.numberOfGames}'),
                if (!(snapshot.data is Done || snapshot.data is Initial))
                  CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      );
}
