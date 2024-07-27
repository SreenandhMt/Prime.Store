import 'package:main_work/features/home/domain/entities/home_entitie.dart';

import '../../domain/entities/home_category_entities.dart';

class HomeCategoryData extends HomeCategoryDataEntities {
  const HomeCategoryData(
      {required String shopId,
      required String shopName,
      required String imageUrl,
      required List<HomeDataEntities> products})
      : super(
            imageUrl: imageUrl,
            products: products,
            shopId: shopId,
            shopName: shopName);
}
