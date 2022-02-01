import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '/sys.dart';
import '/UI/comps/LoadingComp.dart';
import '/logic/bloc/login_bloc.dart';
import 'package:flutter/services.dart';

import 'menuScreen.dart';

TextEditingController _usernameCon = TextEditingController();
TextEditingController _ageCon = TextEditingController();

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc()..add(LoginCheck()),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: mnColor,
          body: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return (state is LoginInitial)
                  ? const LoadingComp()
                  : (state is LoginIsWaiting)
                      ? LoginPage(context)
                      : (state is LoginIsNew)
                          ? const LoadingComp()
                          : menuScreen(
                              username: state.username,
                              age: state.age,
                            );
            },
          ),
        ),
      ),
    );
  }
}

Widget LoginPage(BuildContext context) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        color: Colors.white,
        child: SvgPicture.asset(
          'assets/logo.svg',
          color: frColor,
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(32, 32, 32, 8),
        child: TextField(
          style: TextStyle(color: frColor),
          cursorColor: frColor,
          controller: _usernameCon,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1.5,
                  color: frColor,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              hintText: "your name ...",
              hintStyle: TextStyle(color: frColor)),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(32, 0, 32, 8),
        child: TextField(
          keyboardType: TextInputType.number,
          style: TextStyle(color: frColor),
          cursorColor: frColor,
          controller: _ageCon,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1.5,
                  color: frColor,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              hintText: "your age ...",
              hintStyle: TextStyle(color: frColor)),
        ),
      ),
      TextButton(
          onPressed: () {
            if (_usernameCon.text.isNotEmpty && _ageCon.text.isNotEmpty) {
              context.read<LoginBloc>().add(Login(_usernameCon.text, int.tryParse(_ageCon.text) ?? 20));
            }
          },
          child: Text(
            'start playing',
            style: TextStyle(color: frColor, fontSize: 20.0),
          ))
    ],
  );
}
