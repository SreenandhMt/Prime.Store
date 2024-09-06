import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../../home/domain/entities/home_entitie.dart';
import '../../../selling/selling_page.dart';

class ProductWidgetForAccountPage extends StatelessWidget {
  const ProductWidgetForAccountPage({
    Key? key,
    required this.data,
  }) : super(key: key);
  final HomeDataEntities data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
      return GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SellingPage(data: data),
        )),
        child: Container(
          margin: const EdgeInsets.all(3.5),
          width: size.width <= 700 ? (size.width / 2 ) * 0.96:size.width <= 1300?(size.width) * 0.21: size.width * 0.18,
          height: size.width <= 700 ? (size.width) * 0.7:size.width <= 1300?(size.width) * 0.33 : (size.width) * 0.26,
          decoration: BoxDecoration(color: theme.primary),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                    constraints: const BoxConstraints(
                    ),
                    child: Image.network(data.productUrls!.first)),
              ),
              
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      width: (size.width / 2) * 0.95,
                      height: 80,
                      color: Theme.of(context).colorScheme.primary,
                      child: ProductText(
                        data: data,
                      ))),
            ],
          ),
        ),
      );
  }
}

class MyProducts extends StatelessWidget {
  const MyProducts({
    Key? key,
    required this.data,
  }) : super(key: key);
  final HomeDataEntities data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width <= 500) {
      return GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SellingPage(
            data: data,
          ),
        )),
        child: Container(
          margin: const EdgeInsets.all(3.5),
          width: (size.width / 2) * 0.96,
          height: (size.width) * 0.68,
          decoration: BoxDecoration(color: theme.primary),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 230,
                    ),
                    child: Image.network(data.productUrls!.first)),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      width: (size.width / 2) * 0.95,
                      height: 80,
                      color: Theme.of(context).colorScheme.primary,
                      child: ProductText(
                        data: data,
                      ))),
            ],
          ),
        ),
      );
    } else {
      return Container(
        height: 500,
        width: 300,
        margin: const EdgeInsets.all(3.5),
        color: theme.primary,
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                width: (size.width / 2) * 0.95,
                height: 80,
                color: theme.primary,
                child: ProductText(
                  data: data,
                ))),
      );
    }
  }
}

class ProductText extends StatelessWidget {
  const ProductText({
    Key? key,
    required this.data,
  }) : super(key: key);
  final HomeDataEntities data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.productName ?? "",
            maxLines: 1,
            style: TextStyle(color: theme.tertiary),
          ),
          Text(
            data.productAbout ?? "",
            style: const TextStyle(),
            maxLines: 1,
            overflow: TextOverflow.clip,
          ),
          Row(
            children: [
              Icon(
                Icons.star_rounded,
                color: Colors.yellow[600],
                size: 20,
              ),
              Text(
                "4.9|200",
                style: TextStyle(color: theme.tertiary),
              ),
              const Expanded(child: SizedBox()),
              Text(
                "${data.map!["price"] ?? ""}",
                style: TextStyle(fontSize: 16, color: theme.secondary),
              )
            ],
          ),
        ],
      ),
    );
  }
}