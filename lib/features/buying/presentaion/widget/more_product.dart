import 'package:flutter/material.dart';

import 'package:main_work/features/buying/presentaion/widget/text_divider.dart';
import 'package:main_work/features/home/domain/entities/home_category_entities.dart';

import '../../../home/presentation/widgets/home_widgets.dart';

class MoreProduct extends StatelessWidget {
  const MoreProduct({
    Key? key,
    required this.dataList,
  }) : super(key: key);
  final HomeCategoryDataEntities dataList;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Column(
          children: [
            TextDivider(text: "More Products"),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: LimitedBox(
                maxWidth: size.width <= 1000 ? (size.width / 2 ) * 0.96:size.width * 0.2,
              maxHeight:size.width <= 700 ? (size.width) * 0.7:size.width <= 1300?(size.width) * 0.33 : (size.width) * 0.26,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(dataList!.products!.length,
                      (index) => ProductWidget(data: dataList!.products![index],dataList: dataList,)),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(onTap: () {
            
          },child: const CircleAvatar(radius: 14,child: Icon(Icons.keyboard_arrow_right_sharp),)),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: InkWell(onTap: () {
            
          },child: const CircleAvatar(radius: 14,child: Icon(Icons.keyboard_arrow_left_sharp),)),
        ),
      ],
    );
  }
}
