import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

List listordered = [];

class ResultListComp extends StatelessWidget {
  final List list;

  const ResultListComp({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    listordered = list;
    for (List i in listordered) {
      if (i[1] < 0) {
        i[1] = 9999;
      }
    }
    listordered.sort((a, b) => a[1].compareTo(b[1]));
    return Column(
      children: [
        for (int i = 0; i < listordered.length; i++)
          ListTile(
            leading: CircleAvatar(
              child: Text(
                (listordered[i][1] == 9999) ? 'loser' : (i + 1).toString(),
              ),
              backgroundColor: (i == 0) ? Colors.amber : Colors.blue,
            ),
            subtitle: Text((listordered[i][1] == 9999) ? 'loser tochaha 9bl l red' : StopWatchTimer.getDisplayTime(listordered[i][1] ?? '0', hours: false).toString()),
            title: Text(listordered[i][0]),
          )
      ],
    );
  }
}
