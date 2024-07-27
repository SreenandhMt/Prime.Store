import 'package:equatable/equatable.dart';

class CartEntities extends Equatable {
  final List<dynamic>? productUrls;
  final String? productName;
  final String? productAbout;
  final List<dynamic>? highlights;
  final String? productId;
  final String? sellerId;
  final int? colors;
  final List<dynamic>? colorList;
  final List<dynamic>? sizeList;
  final String? size;
  final Map? map;

  const CartEntities({
    this.productUrls,
    this.productName,
    this.productAbout,
    this.highlights,
    this.productId,
    this.sellerId,
    this.colors,
    this.colorList,
    this.sizeList,
    this.size,
    this.map,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    productUrls,
    productName,
    productAbout,
    highlights,
    productId,
    sellerId,
    colors,
    size,
    colorList,
    sizeList,
    map,
  ];
  
}
