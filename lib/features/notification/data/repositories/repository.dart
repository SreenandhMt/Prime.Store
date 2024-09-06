import 'package:main_work/features/notification/data/data_sources/data_source.dart';

import '/features/notification/domain/repositories/repository.dart';

class NotificationRepositoryImp implements NotificationRepository{
  final NotificationDataSource _dataSource;
  NotificationRepositoryImp(this._dataSource);

  // @override
  // Future<void> updateNotification({required String status, required String id, required Map<String, dynamic> data}) {
  //  return _dataSource.updateNotification(status: 0, id: id, data: );
  // }
  
}