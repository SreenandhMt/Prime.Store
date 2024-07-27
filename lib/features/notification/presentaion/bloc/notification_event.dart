part of 'notification_bloc.dart';

@immutable
sealed class NotificationEvent {}

final class NotificationData extends NotificationEvent {}
final class UpdateNotification extends NotificationEvent {
  final String status;
  final String id;
  final Map<String,dynamic> data;

  UpdateNotification({required this.status, required this.id,required this.data});
}