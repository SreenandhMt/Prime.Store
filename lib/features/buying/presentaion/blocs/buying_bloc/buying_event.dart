part of 'buying_bloc.dart';

@immutable
sealed class BuyingEvent {}

final class GetProductInfo extends BuyingEvent {
  final String productId;
  final bool? noData;

  GetProductInfo({required this.productId,this.noData}); 
}
final class UpdateState extends BuyingEvent {
}


