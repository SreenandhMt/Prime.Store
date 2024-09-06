part of 'notification_bloc.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class NotificationDataState extends NotificationState {
  final List<AccountOrdersDataEntities> data;

  NotificationDataState({required this.data});

}