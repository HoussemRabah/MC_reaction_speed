import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/UI/comps/DrawerComp.dart';
import '/UI/comps/ResultsListComp.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import '/logic/bloc/sqaure_bloc.dart';
import '/UI/comps/AppBarComp.dart';
import '/sys.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

int score = 0;

class _GameScreenState extends State<GameScreen> {
  List playersList = [];

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countUp,
      onChange: (value) {
        score = value;
      });

  @override
  void initState() {
    score = 0;
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;

    playersList.add(arguments['username']);
    playersList.addAll(arguments['players']);

    return BlocProvider(
      create: (context) => SqaureBloc(playersList),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: mnColor,
          appBar: AppBarComp(context),
          drawer: const DrawerComp(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {},
              child: BlocBuilder<SqaureBloc, SqaureState>(builder: (context, state) {
                if (state is SqaureRedState) {
                  _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                  return TextButton(
                      onPressed: () {
                        _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                        context.read<SqaureBloc>().add(SqaureStop(score, true));
                      },
                      child: const Icon(
                        Icons.stop,
                        color: Colors.white,
                      ));
                }
                if (state is SqaureBeginState) {
                  return TextButton(
                      onPressed: () {
                        _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                        context.read<SqaureBloc>().add(SqaureStop(0, false));
                      },
                      child: const Icon(Icons.stop, color: Colors.white));
                }
                if (state is SqaureStopState) {
                  return TextButton(
                      onPressed: () {
                        _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                        context.read<SqaureBloc>().add(SqaureReset());
                      },
                      child: const Icon(Icons.restore, color: Colors.white));
                }
                if (state is SqaureResultState) {
                  return TextButton(
                      onPressed: () {
                        _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                        context.read<SqaureBloc>().add(SqaureReset());
                      },
                      child: const Icon(Icons.restore, color: Colors.white));
                }
                return TextButton(
                    onPressed: () {
                      context.read<SqaureBloc>().add(SqaureStart());
                    },
                    child: const Icon(Icons.play_arrow, color: Colors.white));
              }),
            ),
          ),
          body: BlocBuilder<SqaureBloc, SqaureState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        (state is SqaureStopState)
                            ? ((state.score > 0) ? 'booooom!' : 'too soon.. loser')
                            : (state is SqaureResultState)
                                ? 'results'
                                : (state is SqaureBeginState)
                                    ? 'wait for it...'
                                    : (state is SqaureRedState)
                                        ? 'Nooooow'
                                        : "${state.playername}'s turn",
                        style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    (state is SqaureResultState) ? ResultListComp(list: state.scores) : SizedBox(),
                    (state is SqaureResultState)
                        ? SizedBox()
                        : Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.width * 0.7,
                            color: (state is SqaureRedState)
                                ? Colors.red
                                : (state is SqaureStopState)
                                    ? Colors.blue
                                    : (state is SqaureBeginState)
                                        ? Colors.grey
                                        : Colors.grey.shade50,
                          ),
                    (state is SqaureResultState)
                        ? SizedBox()
                        : StreamBuilder<int>(
                            stream: _stopWatchTimer.rawTime,
                            initialData: 0,
                            builder: (context, snap) {
                              final value = snap.data;
                              final displayTime = StopWatchTimer.getDisplayTime(value ?? 0, hours: false);
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  displayTime,
                                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
