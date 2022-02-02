import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '/UI/comps/DrawerComp.dart';
import '/UI/comps/LoadingComp.dart';
import '/UI/comps/ResultsListComp.dart';
import '/logic/repo/stockage.dart';
import '/UI/comps/AppBarComp.dart';
import '/sys.dart';
import '/UI/comps/BigtitleComp.dart';

Stockage stockage = Stockage();
RefreshController _refreshController = RefreshController(initialRefresh: false);

class menuScreen extends StatefulWidget {
  const menuScreen({Key? key, this.username, this.age}) : super(key: key);
  final String? username;
  final int? age;
  @override
  _menuScreenState createState() => _menuScreenState();
}

class _menuScreenState extends State<menuScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mnColor,
        drawer: const DrawerComp(),
        appBar: AppBarComp(context),
        body: SmartRefresher(
          controller: _refreshController,
          onRefresh: () => setState(() {
            _refreshController.loadComplete();
          }),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const BigtitleComp(title: 'play mode'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await Navigator.of(context).pushNamed('thegame', arguments: {
                          'username': widget.username,
                          'players': []
                        }).then((value) => setState(() {}));
                      },
                      child: Column(
                        children: const [
                          Icon(
                            Icons.face,
                            size: 124.0,
                          ),
                          Text('alone'),
                        ],
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          await Navigator.of(context).pushNamed('friends', arguments: {
                            'username': widget.username
                          }).then((value) => setState(() {}));
                        },
                        child: Column(
                          children: const [
                            Icon(Icons.group, size: 124.0),
                            Text('friends'),
                          ],
                        )),
                  ],
                ),
                const BigtitleComp(title: 'highscores'),
                FutureBuilder<List>(
                  future: stockage.getScores(),
                  builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isNotEmpty) {
                        return ResultListComp(list: (snapshot.data as List));
                      } else {
                        return const Center(child: Text('nothing to show yet'));
                      }
                    }
                    return LoadingComp();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
