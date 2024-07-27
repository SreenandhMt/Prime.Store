import 'package:main_work/features/cart/domain/entities/cart_entities.dart';

class CartDataClass extends CartEntities {
  const CartDataClass(
      {required List<dynamic> productUrls,
      required List<dynamic> colorList,
      required List<dynamic> sizeList,
      required String productName,
      required String productAbout,
      required List<dynamic> highlights,
      required String productId,
      required String sellerId,
      required int colors,
      required String size,
      required Map map})
      : super(
            colors: colors,
            highlights: highlights,
            productAbout: productAbout,
            productId: productId,
            productName: productName,
            productUrls: productUrls,
            sellerId: sellerId,
            size: size,
            map: map,
            colorList: colorList,
            sizeList: sizeList);

  factory CartDataClass.formjson(Map map) {
    return CartDataClass(
        productUrls: map["productUrls"],
        productName: map["productName"],
        productAbout: map["productAbout"],
        highlights: map["highlights"],
        productId: map["productId"],
        sellerId: map["sellerId"],
        colors: 1,
        size: map["size"],
        map: map,
        colorList: map["colorList"] ?? [],
        sizeList: map["sizeList"] ?? []);
  }
}
