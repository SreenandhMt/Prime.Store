import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:main_work/features/cart/domain/entities/cart_entities.dart';

import '../../../../home/domain/entities/home_entitie.dart';
import '../../../domain/usecase/usecase.dart';

part 'confrom_event.dart';
part 'confrom_state.dart';


FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;

class ConfromBloc extends Bloc<ConfromEvent, ConfromState> {
  final BuyingUsecase _usecase;
  ConfromBloc(this._usecase) : super(ConfromInitial()) {
    on<OrderPlace>((event,emit)async{
      emit(ConfromInitial());
      if(_auth.currentUser==null)return;
      final uid = _auth.currentUser!.uid;
      final id = DateTime.now().microsecondsSinceEpoch.toString();
      final map = event.data.map!;
      final data = await _usecase.buyConfrom(map: map as Map<String,dynamic>, uid: uid, id: id);
      if(data=="ok")
      {
        emit(SuccessPayment());
      }else{
        emit(FaildPayment());
      }
    });
    on<SetStateInit>((event,emit)async{
      emit(ConfromInitial());
    });
    on<ClearData>((event,emit)async{
      emit(SuccessPayment());
    });
    on<OrderCartProdecuts>((event,emit)async{
      try {
        emit(ConfromInitial());
      if(_auth.currentUser==null)return;
      final uid = _auth.currentUser!.uid;
      // final id = "${event.data.productId}$uid";
      List<Map<dynamic,dynamic>> map = [];
      for (var data in event.data) {
        map.add(data.map!);
      } 
      final data = await _usecase.buyConfromCartProduct(map: map, uid: uid, id: "");
      if(data=="ok")
      {
        emit(SuccessPayment(removeCartData: event.data));
      }else{
        emit(FaildPayment());
      }
      } catch (e) {
       log(e.toString()); 
      }
    });
    
  }
}
