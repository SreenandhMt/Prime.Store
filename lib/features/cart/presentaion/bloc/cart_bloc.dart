
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_work/features/cart/data/data_sources/local/cart_data_sources.dart';

import '../../domain/entities/cart_entities.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitData>((event, emit) {

    });

    on<CartGetData>((event, emit) async{
      final data = await CartLocalData().getCartData();
      emit(CartData(cartProducts: data));
    });

    on<CartAddData>((event, emit) async{
      final data = await CartLocalData().addCartData(event.map);
      emit(CartData(cartProducts: data));
    });

    on<CartDeleteData>((event, emit) async{
      final data = await CartLocalData().deleteCartData(event.productId);
      emit(CartData(cartProducts: data));
    });
  }
}
