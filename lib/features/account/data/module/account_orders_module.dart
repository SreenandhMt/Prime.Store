import '../../domain/entities/account_orders_entities.dart';

class AccountOrdersData extends AccountOrdersDataEntities {
  const AccountOrdersData(
      {
      required String productId,
      required String sellerId,
      required int colors,
      required String size,
      required String status,
      required Map<String,dynamic> map
      })
      : super(
            colors: colors,
            productId: productId,
            sellerId: sellerId,
            size: size,
            status: status,map: map);

  factory AccountOrdersData.formjson(Map map,Map<String,dynamic> productmap) {
    return AccountOrdersData(
        productId: map["productId"],
        sellerId: map["sellerId"],
        colors: 1,
        size: map["size"],
        map:productmap,
        status: map["status"]??"null",);
  }
}
