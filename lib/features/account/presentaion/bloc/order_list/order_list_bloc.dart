import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/account/domain/usecase/account_usecase.dart';

import '../../../domain/entities/account_orders_entities.dart';

part 'order_list_event.dart';
part 'order_list_state.dart';
FirebaseAuth _auth = FirebaseAuth.instance;

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {
  final AccountUsecase _usecase;
  OrderListBloc(this._usecase) : super(OrderListInitial()) {
    on<GetOrderList>((event, emit)async {
      if(_auth.currentUser==null)return;
      final orderData = await _usecase.getMyOrderHistory(id: _auth.currentUser!.uid);
      log("=> $orderData");
      emit(OrderList(data: orderData));
    });
  }
}
