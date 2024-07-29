part of 'buying_bloc.dart';

@immutable
sealed class BuyingEvent {}

final class GetFavoritState extends BuyingEvent {
  final String productId;

  GetFavoritState({required this.productId}); 
}
