part of 'buying_bloc.dart';

@immutable
sealed class BuyingEvent {}

final class GetProductInfo extends BuyingEvent {
  final String productId;

  GetProductInfo({required this.productId}); 
}
