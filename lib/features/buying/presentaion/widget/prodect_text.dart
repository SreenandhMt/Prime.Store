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
                Text(
                  "₹ ${homeData.map!["price"]??""}",
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
                  homeData.map!["rate1"] == null ? "3" : ratingText(),
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Icon(Icons.mobile_friendly,color: Colors.grey,),
              const SizedBox(width: 6,),
              Text(
                homeData.productName ?? "",
                style: const TextStyle(
                    color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text(
            homeData.productAbout!,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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