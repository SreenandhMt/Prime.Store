import 'package:equatable/equatable.dart';

import 'home_entitie.dart';

class HomeCategoryDataEntities extends Equatable {
  final String? shopId;
  final String? shopName;
  final String? imageUrl;
  final List<HomeDataEntities>? products;

  const HomeCategoryDataEntities({
    this.shopId,
    this.shopName,
    this.imageUrl,
    this.products,
  });

  @override
  List<Object?> get props => [
    shopId,
     shopName,
     imageUrl,
     products
  ];
  
}
