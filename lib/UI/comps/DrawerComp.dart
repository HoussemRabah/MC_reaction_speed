import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/sys.dart';
import '/UI/comps/LoadingComp.dart';
import '/logic/repo/stockage.dart';

Stockage stockage = Stockage();

class DrawerComp extends StatelessWidget {
  const DrawerComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: FutureBuilder<Map>(
            future: stockage.getInfo(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          'assets/logo.svg',
                          color: frColor,
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Hey, ${snapshot.data!['username'].toString()}',
                            style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Remember, you are only ${snapshot.data!['age'].toString()} years old'),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return (LoadingComp());
            }),
      ),
    );
  }
}
