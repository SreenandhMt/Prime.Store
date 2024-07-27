part of 'favorit_bloc.dart';

@immutable
sealed class FavoritState {}

final class FavoritInitial extends FavoritState {}

final class Massages extends FavoritState {}
final class Data extends FavoritState {
  final List<AccountFavoritDataEntities> data;
  Data({required this.data});
}