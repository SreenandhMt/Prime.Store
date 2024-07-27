part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}
final class CartData extends CartState {
  final List<CartEntities> cartProducts;
  CartData({required this.cartProducts});
}
final class CartMassage extends CartState {}
final class CartLoading extends CartState {}