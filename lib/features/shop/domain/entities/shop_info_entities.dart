import 'package:equatable/equatable.dart';

import '../../../../core/main_data/entities/address_entities.dart';
import '../../../home/domain/entities/home_entitie.dart';

class ProductInfoDataEntities extends Equatable {
  final String? productId;
  final String? sellerId;
  final String? colors;
  final String? size;
  final String? status;
  final String? orderTime;
  final String? shippedTime;
  final String? outOfDeliveryTime;
  final String? deliveryTime;
  final HomeDataEntities? map;
  final AddressDataEntities? sellerAddress;
  final AddressDataEntities? buyerAddress;
  Map<String,dynamic>? orderMap;
  ProductInfoDataEntities({
    this.productId,
    this.sellerId,
    this.colors,
    this.size,
    this.status,
    this.orderTime,
    this.shippedTime,
    this.outOfDeliveryTime,
    this.deliveryTime,
    this.map,
    this.sellerAddress,
    this.buyerAddress,
    this.orderMap,
  });

  @override
  List<Object?> get props => [
    productId,
    sellerId,
    sellerAddress,
    size,
    colors,
    status,
    map,
    buyerAddress,
    deliveryTime,
    shippedTime,
    outOfDeliveryTime,
    orderTime,
    orderMap,
  ];
  
}
