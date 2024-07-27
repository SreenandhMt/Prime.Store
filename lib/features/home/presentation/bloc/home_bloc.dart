import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_work/features/home/domain/entities/home_category_entities.dart';
import 'package:main_work/features/home/domain/usecase/home_usecase.dart';


part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeUsecase _homeUsecase;
  HomeBloc(this._homeUsecase) : super(HomeInitial()) {
    on<GetData>((event, emit) async{
      final data = await _homeUsecase.getFeed();
      emit(HomeData(data: data!));
    });
  }
}
