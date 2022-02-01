import 'package:flutter/material.dart';

class BigtitleComp extends StatelessWidget {
  final String title;

  const BigtitleComp({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900),
          ),
        )
      ],
    );
  }
}
