part of 'notification_bloc.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class NotificationDataState extends NotificationState {
  final List<Map<String,dynamic>> data;
  final List<Map<String,dynamic>?> location;
  final List<Map<String,dynamic>?> productData;

  NotificationDataState({required this.data, required this.location,required this.productData});

}