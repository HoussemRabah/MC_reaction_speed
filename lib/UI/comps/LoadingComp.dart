import 'package:flutter/material.dart';

class LoadingComp extends StatelessWidget {
  const LoadingComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
