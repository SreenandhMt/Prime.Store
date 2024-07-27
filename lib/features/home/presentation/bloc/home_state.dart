part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeData extends HomeState {
  final List<HomeCategoryDataEntities> data;

  const HomeData({required this.data});
}