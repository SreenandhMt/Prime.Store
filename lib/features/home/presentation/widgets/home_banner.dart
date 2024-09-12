import 'package:flutter/material.dart';

import 'package:main_work/core/theme/themes.dart';
import 'package:main_work/main.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(gradient: LinearGradient(colors: [theme.background,Theme.of(context)==darkTheme?Colors.grey:const Color.fromARGB(255, 53, 51, 51)],end: Alignment.bottomCenter,begin: Alignment.topCenter),image: DecorationImage(image: NetworkImage(url),fit: size.width<=1000?BoxFit.cover:null)),
      height: size.width<=1000?size.width*0.4 : 100,
      width: 400,
    );
  }
}
