
import '/features/notification/domain/repositories/repository.dart';

class NotificationUsecase{
  final NotificationRepository _dataSource;
  NotificationUsecase(this._dataSource);

  Future<void> updateNotification({required String status, required String id, required Map<String, dynamic> data}) {
   return _dataSource.updateNotification(status: status, id: id, data: data);
  }
  
}