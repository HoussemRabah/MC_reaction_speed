part of 'sqaure_bloc.dart';

@immutable
abstract class SqaureEvent {}

class SqaureStart extends SqaureEvent {}

class SqaureStop extends SqaureEvent {
  int score;
  bool stopedAfterRed;
  SqaureStop(this.score, this.stopedAfterRed) : super();
}

class SqaureRedStart extends SqaureEvent {}

class SqaureReset extends SqaureEvent {}
