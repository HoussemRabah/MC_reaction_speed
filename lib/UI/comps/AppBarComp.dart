import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../sys.dart';

AppBar AppBarComp(BuildContext context) {
  return AppBar(
    foregroundColor: mnColor,
    backgroundColor: frColor,
    elevation: 0.0,
    leading: Builder(builder: (context) {
      return TextButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        child: SvgPicture.asset(
          'assets/logo.svg',
          color: Colors.white,
        ),
      );
    }),
    title: Text('reaction speed'),
  );
}
