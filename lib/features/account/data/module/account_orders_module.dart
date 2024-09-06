import 'package:main_work/core/main_data/entities/address_entities.dart';
import 'package:main_work/features/home/data/module/home_module.dart';
import 'package:main_work/features/home/domain/entities/home_entitie.dart';

import '../../domain/entities/account_orders_entities.dart';

class AccountOrdersData extends AccountOrdersDataEntities {
  
  AccountOrdersData(
      {required String productId,
      required String sellerId,
      required String colors,
      required String size,
      required String status,
      required String orderTime,
      required String shippedTime,
      required String outOfDeliveryTime,
      required String deliveryTime,
      required HomeDataEntities map,
      required AddressDataEntities sellerAddress,
      required AddressDataEntities buyerAddress,
      required Map<String, dynamic> orderMap})
      : super(buyerAddress: buyerAddress,colors: colors,deliveryTime: deliveryTime,map: map,orderMap: orderMap,orderTime: orderTime,outOfDeliveryTime: outOfDeliveryTime,productId: productId,sellerAddress: sellerAddress,sellerId: sellerId,shippedTime: shippedTime,size: size,status: status);

  factory AccountOrdersData.formjson(map,Map<String,dynamic> productmap,AddressDataEntities buyeraddress,AddressDataEntities selleraddress) {
    return AccountOrdersData(productId: map["productId"], sellerId: map["sellerId"], colors: map["selected_color"]??"", size: map["selected_size"]??"", status: map["status"].toString(), orderTime: map["orderTime"], shippedTime: map["shippedTime"]??"", outOfDeliveryTime: map["outOfDeliveryTime"]??"", deliveryTime: map["deliveryTime"]??"", map: HomeData.formjson(productmap), sellerAddress: selleraddress, buyerAddress: buyeraddress, orderMap: map);
  }
}
