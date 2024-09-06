
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/data_sources/local/accout_data_sources.dart';
import '../../../domain/entities/account_favorit_entities.dart';
import '../../../domain/entities/account_orders_entities.dart';
import '../../../domain/usecase/account_usecase.dart';

part 'account_event.dart';
part 'account_state.dart';
FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountUsecase _usecase;
  AccountBloc(this._usecase) : super(AccountInitial()) {
   on<GetFavoriteData>((event, emit) async{
    if(state is !GetAccountDatas)
    {
      emit(AccountInitial());
    }
      final data = await AccountFavoritDataSources().getData();
      final orderData = await _usecase.getMyOrderHistory(id: _auth.currentUser!.uid);
      final profile = await _firestore.collection("profile").doc(_auth.currentUser!.uid).get().then((value) => value.data(),);
      emit(GetAccountDatas(favoriteData: data,ordersData: orderData.data!,profile: profile));

    });
    on<DeleteData>((event, emit) async{
      await AccountFavoritDataSources().deleteData(event.productId);
      final data = await AccountFavoritDataSources().getData();
      final orderData = await _usecase.getMyOrderHistory(id: _auth.currentUser!.uid);
       final profile = await _firestore.collection("profile").doc(_auth.currentUser!.uid).get().then((value) => value.data(),);
      emit(GetAccountDatas(favoriteData: data,ordersData: orderData.data!,profile: profile));
    });
    on<AddData>((event, emit) async{
      await AccountFavoritDataSources().addData(event.map);
      final data = await AccountFavoritDataSources().getData();
      final orderData = await _usecase.getMyOrderHistory(id: _auth.currentUser!.uid);
       final profile = await _firestore.collection("profile").doc(_auth.currentUser!.uid).get().then((value) => value.data(),);
      emit(GetAccountDatas(favoriteData: data,ordersData: orderData.data!,profile: profile));
    });
     on<GetOrderList>((event, emit)async {
      try {
        if(_auth.currentUser==null)return;
        final orderData = await _usecase.getMyOrderHistory(id: _auth.currentUser!.uid);
        final data = await AccountFavoritDataSources().getData();
         final profile = await _firestore.collection("profile").doc(_auth.currentUser!.uid).get().then((value) => value.data(),);
      emit(GetAccountDatas(favoriteData: data,ordersData: orderData.data!,profile: profile));
      } catch (e) {
      }
    });
    on<EditProfile>((event, emit)async {
      try {
        if(_auth.currentUser==null)return;
        await _firestore.collection("profile").doc(_auth.currentUser!.uid).set(
          {
            "name":event.name,
            "number":event.phoneNumber,
            "birthday":event.birthday,
            "email":event.email,
            "gender":event.gender,
          }
        );
      } catch (e) {
      }
    });
  }
}
