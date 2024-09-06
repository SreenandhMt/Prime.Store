part of 'confrom_bloc.dart';

@immutable
sealed class ConfromEvent {}


final class OrderPlace extends ConfromEvent {
  final HomeDataEntities data;
  final String selectedColor;
  final String selectedSize;
  final String itemCount;

  OrderPlace({required this.data, required this.selectedColor, required this.selectedSize, required this.itemCount});
}

final class OrderCartProdecuts extends ConfromEvent {
  final List<CartEntities> data;
  
  OrderCartProdecuts({required this.data});
}

final class SetStateInit extends ConfromEvent {}
final class ClearData extends ConfromEvent {}
final class CheckRequest extends ConfromEvent {}