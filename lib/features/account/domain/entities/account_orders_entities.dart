import 'package:equatable/equatable.dart';

class AccountOrdersDataEntities extends Equatable {
  final String? productId;
  final String? sellerId;
  final int? colors;
  final String? size;
  final String? status;
  final Map<String,dynamic>? map;

  const AccountOrdersDataEntities({
    this.productId,
    this.sellerId,
    this.colors,
    this.size,
    this.status,
    this.map
  });

  @override
  List<Object?> get props => [
    productId,
    sellerId,
    colors,
    size,
    status,
    map,
  ];
  
}
