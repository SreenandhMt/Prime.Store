part of 'buying_bloc.dart';

@immutable
sealed class BuyingEvent {}

final class GetFavoritState extends BuyingEvent {
  final String productId;

  GetFavoritState({required this.productId}); 
}

final class OrderPlace extends BuyingEvent {
  final HomeDataEntities data;

  OrderPlace({required this.data});
}