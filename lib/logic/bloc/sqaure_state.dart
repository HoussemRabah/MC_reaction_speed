part of 'sqaure_bloc.dart';

@immutable
abstract class SqaureState {
  String playername;
  SqaureState(this.playername) : super();
}

class SqaureInitial extends SqaureState {
  String username;

  SqaureInitial(this.username) : super(username);
}

class SqaureBeginState extends SqaureState {
  String playername;

  SqaureBeginState(this.playername) : super(playername);
}

class SqaureRedState extends SqaureState {
  String playername;

  SqaureRedState(this.playername) : super(playername);
}

class SqaureStopState extends SqaureState {
  String playername;
  int score;

  SqaureStopState(this.playername, this.score) : super(playername);
}

class SqaureResultState extends SqaureState {
  String playername;
  List scores;

  SqaureResultState(this.playername, this.scores) : super(playername);
}
