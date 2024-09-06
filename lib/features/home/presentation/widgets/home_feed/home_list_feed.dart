import 'package:flutter/material.dart';

import 'package:main_work/features/home/presentation/widgets/home_widgets.dart';

import '../../../domain/entities/home_category_entities.dart';

class HomeProductListWidget extends StatelessWidget {
  const HomeProductListWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final HomeCategoryDataEntities data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width<=700?null:size.width*0.7,
      child:Wrap(
        children: List.generate(data.products!.length<=4?data.products!.length:size.width>=1000?data.products!.length:4, (index) => ProductWidget(data: data.products![index],dataList: data,)),
      ),
    );
  }
}
