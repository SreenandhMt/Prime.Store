part of 'confrom_bloc.dart';

@immutable
sealed class ConfromState {}

class ConfromInitial extends ConfromState {}

class FaildPayment extends ConfromState{}
class LoginRequest extends ConfromState{}
class AddressRequest extends ConfromState{}
class SuccessPayment extends ConfromState {
  final List<CartEntities>? removeCartData;

  SuccessPayment(
    {this.removeCartData,}
  );
}
