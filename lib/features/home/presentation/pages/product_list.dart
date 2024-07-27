import 'package:flutter/material.dart';
import 'package:main_work/features/home/presentation/widgets/home_widgets.dart';

import '../../domain/entities/home_entitie.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
    required this.data,
  }) : super(key: key);
  final List<HomeDataEntities> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Wrap(
          children: List.generate(data.length, (index) => ProductWidget(data: data[index])),
        ),
      ),
    );
  }
}
