import 'package:flutter/material.dart';
import 'package:main_work/core/theme/themes.dart';
import 'package:main_work/main.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: LinearGradient(colors: [theme.background,Theme.of(context)==darkTheme?Colors.grey:Color.fromARGB(255, 53, 51, 51)],end: Alignment.bottomCenter,begin: Alignment.topCenter)),
      height: 130,
      width: 400,
    );
  }
}