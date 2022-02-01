import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/UI/screens/gameScreen.dart';
import '/UI/screens/playersScreen.dart';

import 'UI/screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.redAccent, textTheme: GoogleFonts.robotoTextTheme()),
    initialRoute: '/',
    routes: {
      '/': (context) => const Home(),
      'friends': (context) => const PlayersScreen(),
      'thegame': (context) => const GameScreen(),
    },
  ));
}
