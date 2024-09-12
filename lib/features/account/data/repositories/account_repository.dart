import 'package:main_work/features/account/data/data_sources/remote/remote_data_source.dart';
import 'package:main_work/features/account/domain/entities/account_orders_entities.dart';

import '../../domain/repositories/account_repository.dart';

class AccountRepositoryImp implements AccountRepository {
  final AccountRemoteDataSource _dataSource;
  AccountRepositoryImp(this._dataSource);
  @override
  Future<({List<AccountOrdersDataEntities>? data , String? errorMassage})> cancelMyOrder({required String id, required String productId}) {
    return _dataSource.cancelMyOrder(id: id, productId: productId);
  }

  @override
  Future<({List<AccountOrdersDataEntities>? data , String? errorMassage})> deleteOrderHistory({required String id, required String productId}) {
    return _dataSource.deleteOrderHistory(id: id,productId: productId);
  }

  @override
  Future<({List<AccountOrdersDataEntities>? data , String? errorMassage})> getMyOrderHistory({required String id}) {
    return _dataSource.getMyOrderHistory(id: id);
  }

  // @override
  // Future<List<AccountOrdersDataEntities>> getMyOrderReturn({required String id, required String productId}) {
  // 
  //   throw UnimplementedError();
  // }
  
}