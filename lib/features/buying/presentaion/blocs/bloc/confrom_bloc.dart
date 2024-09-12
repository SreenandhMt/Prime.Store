import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      final state = await checkRequests();
      if(state!=null)
      {
        emit(state);
        return;
      }
      if(_auth.currentUser==null)return;
      final uid = _auth.currentUser!.uid;
      final id = DateTime.now().microsecondsSinceEpoch.toString();
      final map = event.data.map!;
      final data = await _usecase.buyConfrom(map: map as Map<String,dynamic>, uid: uid, id: id,itemCount: event.itemCount,selectedColor: event.selectedColor,selectedSize: event.selectedSize);
      if(data=="ok")
      {
        emit(SuccessPayment());
      }else{
        emit(FaildPayment());
      }
    });
    on<CheckRequest>((event, emit) async {
      
    });
    on<ClearData>((event,emit)async{
      emit(SuccessPayment());
    });
    on<SetStateInit>((event,emit)async{
      emit(ConfromInitial());
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

  Future<ConfromState?> checkRequests()async{
    if(FirebaseAuth.instance.currentUser==null)
      {
        return LoginRequest();
      }
      final st = await _firebaseFirestore
          .collection("address")
          .where("uid", isEqualTo: _auth.currentUser!.uid)
          .get()
          .then((value) => value.docs
              .map(
                (e) => e.data(),
              )
              .toList());
      if (st.isEmpty) {
        return AddressRequest();
      } else {
        return null;
      }
  }
}
