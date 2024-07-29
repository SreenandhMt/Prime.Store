import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_work/features/account/data/data_sources/local/accout_data_sources.dart';

import '../../../domain/entities/account_favorit_entities.dart';

part 'favorit_event.dart';
part 'favorit_state.dart';

class FavoritBloc extends Bloc<FavoritEvent, FavoritState> {
  FavoritBloc() : super(FavoritInitial()) {
    on<FavoritInit>((event, emit) {});
    on<GetData>((event, emit) async{
      if(state is !Data)
      {
        emit(FavoritInitial());
        await Future.delayed(const Duration(seconds: 3));
      }
      final data = await AccountFavoritDataSources().getData();
      log(data.toString());
      emit(Data(data: data));
    });
    on<DeleteData>((event, emit) async{
      await AccountFavoritDataSources().deleteData(event.productId);
      final data = await AccountFavoritDataSources().getData();
      log(data.toString());
      emit(Data(data: data));
    });
    on<AddData>((event, emit) async{
      await AccountFavoritDataSources().addData(event.map);
      final data = await AccountFavoritDataSources().getData();
      log(data.toString());
      emit(Data(data: data));
    });
  }
}
