part of 'order_list_bloc.dart';

@immutable
sealed class OrderListEvent{}

final class GetOrderList extends OrderListEvent {}