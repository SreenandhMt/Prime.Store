part of 'order_list_bloc.dart';

@immutable
sealed class OrderListState {}

final class OrderListInitial extends OrderListState {}
final class OrderList extends OrderListState {
  final ({List<AccountOrdersDataEntities>? data , String? errorMassage}) data;

  OrderList({required this.data});
}