import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import '/logic/repo/stockage.dart';
import 'package:meta/meta.dart';

part 'sqaure_event.dart';
part 'sqaure_state.dart';

class SqaureBloc extends Bloc<SqaureEvent, SqaureState> {
  List players;
  int currentPlayer = 0;
  List scores = [];
  int currentplaytime = 0;
  Stockage stockage = Stockage();

  SqaureBloc(this.players) : super(SqaureInitial(players[0])) {
    scores = [
      for (int i = 0; i < players.length; i++) 0
    ];
    on<SqaureEvent>((event, emit) async {
      if (event is SqaureStart) {
        int randomDuration = 3000 + Random().nextInt(4) * 1000 + Random().nextInt(9) * 100 + Random().nextInt(9) * 10 + Random().nextInt(10);
        print(randomDuration);
        emit(SqaureBeginState(players[currentPlayer]));
        int now = currentplaytime; // for kill future process
        await Future.delayed(Duration(milliseconds: randomDuration), () {
          if (currentplaytime == now) {
            emit(SqaureRedState(players[currentPlayer]));
          }
        });
      }

      if (event is SqaureStop) {
        currentplaytime++;
        scores[currentPlayer] = (event.stopedAfterRed) ? event.score : -1;
        emit(SqaureStopState(players[currentPlayer], scores[currentPlayer]));
      }

      if (event is SqaureReset) {
        currentPlayer++;
        if (currentPlayer >= (players.length)) {
          List results = [
            for (int i = 0; i < players.length; i++)
              [
                players[i],
                scores[i]
              ]
          ];
          if (players.length > 1) {
            emit(SqaureResultState(players[0], results));
            stockage.saveScores(results);
            currentPlayer = -1;
          } else {
            stockage.saveMyScore(results[0][0], results[0][1]);
            emit(SqaureInitial(players[0]));
            currentPlayer = 0;
          }
        } else {
          emit(SqaureInitial(players[currentPlayer]));
        }
      }
    });
  }
}
