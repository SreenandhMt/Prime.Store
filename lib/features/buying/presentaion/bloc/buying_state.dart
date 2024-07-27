part of 'buying_bloc.dart';

@immutable
sealed class BuyingState {}

final class BuyingInitial extends BuyingState {}
final class BuyingPageState extends BuyingState {
  final bool favoritListAdded;
  final bool cartListAdded;
  final List<Map<String,dynamic>>? review;

  BuyingPageState({required this.favoritListAdded, required this.cartListAdded,this.review});

}