part of 'account_bloc.dart';

sealed class AccountState {}
sealed class FavoritState extends AccountState{}
sealed class OrderListState extends AccountState{}

final class AccountInitial extends AccountState {}

//order
final class OrderListInitial extends OrderListState {}
final class GetAccountDatas extends OrderListState {
  final List<AccountOrdersDataEntities> ordersData;
  final List<AccountFavoritDataEntities> favoriteData;
  final Map<String,dynamic>? profile;

  GetAccountDatas({required this.ordersData, required this.favoriteData,this.profile});
}

//favorit
final class FavoritInitial extends FavoritState {}

final class Massages extends FavoritState {}