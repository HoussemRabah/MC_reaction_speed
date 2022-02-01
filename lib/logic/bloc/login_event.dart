part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginFirstTime extends LoginEvent {}

class Login extends LoginEvent {
  String username;
  int age;
  Login(this.username, this.age) : super();
}

class LoginCheck extends LoginEvent {}
