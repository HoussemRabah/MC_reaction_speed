part of 'login_bloc.dart';

@immutable
abstract class LoginState {
  String username; // var to put in UI
  int age;
  LoginState(this.username, this.age) : super();
}

class LoginInitial extends LoginState {
  LoginInitial() : super('', 0);
}

// text field state
class LoginIsWaiting extends LoginState {
  LoginIsWaiting() : super('', 0);
}

// save user name state
class LoginIsNew extends LoginState {
  String newUsername;
  int newAge;
  LoginIsNew(this.newUsername, this.newAge) : super(newUsername, newAge);
}

// login state
class LoginIsDone extends LoginState {
  String username;
  int age;
  LoginIsDone(this.username, this.age) : super(username, age);
}
