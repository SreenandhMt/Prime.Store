part of 'shop_info_bloc.dart';

sealed class ShopInfoEvent {}

final class GetSelledDatas extends ShopInfoEvent {}

final class Delete extends ShopInfoEvent {
  final String id;

  Delete({required this.id});
}

final class UpdateProducts extends ShopInfoEvent {
  final String productName;
  final String id;
  final String productAbout;
  final String productType;
  final dynamic price;
  final String sellerId;
  final List<String>? colorsList;
  final List<String>? sizeList;
  final List<String> imageList;

  UpdateProducts({required this.productName, required this.id, required this.productAbout, required this.productType, required this.price, required this.sellerId, required this.colorsList, required this.sizeList, required this.imageList});

}

final class Sell extends ShopInfoEvent {
  final String productName;
  final String productAbout;
  final String producthigh;
  final String productType;
  final dynamic price;
  final List<String> colorsList;
  final List<String> sizeList;
  final List<XFile?> imageList;

  Sell({required this.productName, required this.productAbout, required this.producthigh, required this.productType,required this.colorsList,required this.sizeList, required this.imageList,required this.price});
}

