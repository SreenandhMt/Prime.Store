part of 'confrom_bloc.dart';

@immutable
sealed class ConfromEvent {}


final class OrderPlace extends ConfromEvent {
  final HomeDataEntities data;

  OrderPlace({required this.data});
}

final class OrderCartProdecuts extends ConfromEvent {
  final List<CartEntities> data;
  
  OrderCartProdecuts({required this.data});
}

final class SetStateInit extends ConfromEvent {}
final class ClearData extends ConfromEvent {}