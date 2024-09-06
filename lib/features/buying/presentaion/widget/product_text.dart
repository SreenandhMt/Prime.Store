import 'package:flutter/material.dart';

import '../../../home/domain/entities/home_entitie.dart';

class BuyingTexts extends StatelessWidget {
  const BuyingTexts({
    Key? key,
    required this.homeData,
  }) : super(key: key);
  final HomeDataEntities homeData;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: Row(
              children: [
                if(size.width>=1000)
                Text(
                  "₹${homeData.map!["price"]??""}.0",
                  style: const TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const Expanded(child: SizedBox()),
                const Icon(
                  Icons.star_rounded,
                  color: Colors.yellow,
                ),
                Text(
                  homeData.map!["rate1"] == null ? "3 | 5" : ratingText(),
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          
              Text(
                homeData.productName ?? "",
                style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold
                    ),
              ),
          SizedBox(height: 10),
          Text(
            homeData.productAbout!,
            style: const TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400),
            maxLines: 3,
            overflow: TextOverflow.clip,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  String ratingText() {
    dynamic top, rateindex;
    for (var i = 1; i <= 5; i++) {
      if (i == 1) {
        top = homeData.map!["rate$i"];
        rateindex = i;
      } else if (homeData.map!["rate$i"] > top) {
        top = homeData.map!["rate$i"];
        rateindex = i;
      }
    }
    return top != null ? "$rateindex | ${top.toString()}" : "";
  }
}