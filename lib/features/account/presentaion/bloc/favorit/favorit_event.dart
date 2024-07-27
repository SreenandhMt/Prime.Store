part of 'favorit_bloc.dart';

@immutable
sealed class FavoritEvent {}

final class FavoritInit extends FavoritEvent{}
final class GetData extends FavoritEvent{}
final class AddData extends FavoritEvent{
  final Map map;
  AddData({required this.map});
}
final class DeleteData extends FavoritEvent{
  final String productId;
  DeleteData({required this.productId});
}