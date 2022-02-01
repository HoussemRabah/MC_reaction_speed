import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String? username;
  int? age;

  init() async {}

  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginCheck) {
        try {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove('username');
          prefs.remove('age');
          prefs.remove('scores');
          username = (prefs.getString('username') ?? '');
          age = (prefs.getInt('age') ?? 0);
        } catch (e) {
          print('error');
        }
        if (username == '') {
          emit(LoginIsWaiting());
        } else {
          emit(LoginIsDone(username!, age!));
        }
      }

      if (event is Login) {
        emit(LoginIsNew((event).username, (event).age));
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('username', (event).username);
        prefs.setInt('age', (event).age);
        emit(LoginIsDone((event).username, (event).age));
      }
    });
  }
}
