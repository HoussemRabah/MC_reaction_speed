import 'package:flutter/material.dart';
import '/UI/comps/BigtitleComp.dart';

import '../../sys.dart';

List<TextEditingController> _con = [
  new TextEditingController(),
];

List<String?> _errors = [
  null
];

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({Key? key}) : super(key: key);

  @override
  _PlayersScreenState createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;

    return SafeArea(
      child: Scaffold(
        backgroundColor: mnColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            bool allNamesAreOkey = true;
            List<String> players = [];
            for (int i = 0; i < _con.length; i++) {
              players.add(_con[i].text);
              if (_con[i].text.isEmpty) {
                _errors[i] = 'please aktab name wla facih ray7 mat7rch';
                allNamesAreOkey = false;
              }
              if (_con[i].text == arguments['username']) {
                _errors[i] = 'user maklh yktab name ta3o';
                allNamesAreOkey = false;
              }
            }
            setState(() {});

            if (allNamesAreOkey) {
              Navigator.of(context).pushReplacementNamed('thegame', arguments: {
                'username': arguments['username'],
                'players': players
              }).then((value) => setState(() {}));
            }
          },
          child: const Icon(Icons.play_arrow),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const BigtitleComp(title: 'names of your friends'),
              for (int i = 0; i < _con.length; i++)
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: frColor),
                        cursorColor: frColor,
                        controller: _con[i],
                        decoration: InputDecoration(
                          suffixIcon: TextButton(
                            onPressed: () {
                              _con.removeAt(i);
                              _errors.removeAt(i);
                              setState(() {});
                            },
                            child: const Icon(Icons.delete, color: Colors.redAccent),
                          ),
                          errorText: _errors[i],
                          hintText: "player ${i + 2}'s name",
                        ),
                      ),
                    ],
                  ),
                ),
              TextButton(
                  onPressed: () {
                    _con.add(TextEditingController());
                    _errors.add(null);
                    setState(() {});
                  },
                  child: const Icon(Icons.add)),
            ],
          ),
        ),
      ),
    );
  }
}
