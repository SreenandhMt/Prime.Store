part of 'account_bloc.dart';

sealed class AccountEvent {}

final class FavoritEvent extends AccountEvent{}
final class OrderListEvent extends AccountEvent{}

final class GetOrderList extends OrderListEvent {}

final class AddData extends FavoritEvent{
  final Map map;
  AddData({required this.map});
}
final class GetFavoriteData extends FavoritEvent{}
final class DeleteData extends FavoritEvent{
  final String productId;
  DeleteData({required this.productId});
}

final class EditProfile extends AccountEvent{
  final String name;
  final String phoneNumber;
  final String email;
  final String birthday;
  final String gender;

  EditProfile({required this.name, required this.phoneNumber, required this.email, required this.birthday, required this.gender});
}