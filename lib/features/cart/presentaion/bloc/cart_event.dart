part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

final class CartGetData extends CartEvent {}
final class CartAddData extends CartEvent {
  CartAddData({required this.map});
  final Map map;
}
final class CartDeleteData extends CartEvent {
  CartDeleteData({required this.productId});
  final String productId;
}
final class CartInitData extends CartEvent {}