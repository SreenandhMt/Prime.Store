
import 'package:equatable/equatable.dart';

import 'package:main_work/core/main_data/entities/address_entities.dart';
import 'package:main_work/features/home/domain/entities/home_entitie.dart';

class AccountOrdersDataEntities extends Equatable {
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
  AccountOrdersDataEntities({
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
