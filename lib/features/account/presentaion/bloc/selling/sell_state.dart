part of 'sell_bloc.dart';

@immutable
sealed class SellState {}

final class SellInitial extends SellState {}
final class SelledProdects extends SellState {
  final List<AccountSellingDataEntities> data;

  SelledProdects({required this.data});
}

final class Uploading extends SellState {}