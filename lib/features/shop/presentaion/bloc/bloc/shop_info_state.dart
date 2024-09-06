part of 'shop_info_bloc.dart';

sealed class ShopInfoState  {}

final class ShopInfoInitial extends ShopInfoState {}

final class SellInitial extends ShopInfoState {}
final class SelledProdects extends ShopInfoState {
  final List<HomeDataEntities> data;
  final Map<String,dynamic> shopData;
  final AddressDataEntities shopAddress;
  final List<AccountOrdersDataEntities> ordersData;

  SelledProdects({required this.data, required this.shopData, required this.shopAddress, required this.ordersData});
}

final class Uploading extends ShopInfoState {}