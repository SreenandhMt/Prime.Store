part of 'buying_bloc.dart';

@immutable
sealed class BuyingState {}

final class BuyingInitial extends BuyingState {}
final class BuyingPageState extends BuyingState {
  final bool favoritListAdded;
  final bool cartListAdded;
  final List<Map<String,dynamic>>? review;
  final HomeDataEntities? data;
  final AddressDataEntities? shopAddress;
  final HomeCategoryDataEntities moreProduct;

  BuyingPageState({required this.favoritListAdded, required this.cartListAdded, required this.review, required this.data, required this.shopAddress, required this.moreProduct});

}

