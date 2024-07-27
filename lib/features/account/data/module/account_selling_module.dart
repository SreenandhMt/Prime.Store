import '../../domain/entities/account_selling_entities.dart';

class AccountSellingData extends AccountSellingDataEntities {
  const AccountSellingData(
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
      required Map map,
      required String productType})
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
            sizeList: sizeList,
            productType: productType);

  factory AccountSellingData.formjson(Map map) {
    return AccountSellingData(
        productUrls: map["productUrls"],
        productName: map["productName"],
        productAbout: map["productAbout"],
        highlights: map["highlights"],
        productId: map["productId"],
        sellerId: map["sellerId"],
        colors: 1,
        size: map["size"],
        map: map,
        colorList:  [],
        sizeList: map["sizeList"] ?? [],
        productType: map["productType"] ?? "");
  }
}
