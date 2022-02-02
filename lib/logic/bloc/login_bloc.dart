import 'package:bloc/bloc.dart';
import '/logic/repo/stockage.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String? username;
  int? age;
  Stockage stockage = Stockage();

  init() async {}

  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginCheck) {
        try {
          dynamic info = await stockage.getInfo();
          username = info['username'];
          age = info['age'];
        } catch (e) {}
        if (username == '') {
          emit(LoginIsWaiting());
        } else {
          emit(LoginIsDone(username!, age!));
        }
      }

      if (event is Login) {
        emit(LoginIsNew((event).username, (event).age));
        await stockage.setInfo(event.username, event.age);
        emit(LoginIsDone((event).username, (event).age));
      }
    });
  }
}
