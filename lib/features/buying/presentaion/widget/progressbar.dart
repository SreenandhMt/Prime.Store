import 'package:flutter/material.dart';

import 'package:main_work/features/home/domain/entities/home_entitie.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key? key,
    required this.ratingCount,
    required this.value,
    required this.homeData,
  }) : super(key: key);
  final String ratingCount;
  final double value;
  final HomeDataEntities homeData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(ratingCount),
        const SizedBox(
          width: 4,
        ),
        LimitedBox(
          maxWidth: 230,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: LinearProgressIndicator(
              value: (value.toInt() / topRating().toInt()) * topRating(),
              minHeight: 10,
              borderRadius: BorderRadius.circular(10),
              backgroundColor: Colors.grey,
              valueColor: const AlwaysStoppedAnimation(Colors.blue),
            ),
          ),
        ),
      ],
    );
  }
  double topRating() {
    dynamic top;
    for (var i = 1; i <= 5; i++) {
      if (i == 1) {
        top = homeData.map!["rate$i"];
      } else if (homeData.map!["rate$i"] > top) {
        top = homeData.map!["rate$i"];
      }
    }
    return top.toDouble();
  }
}
