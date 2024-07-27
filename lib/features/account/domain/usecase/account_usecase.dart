import 'package:main_work/features/account/domain/repositories/account_repository.dart';

import '../entities/account_orders_entities.dart';

class AccountUsecase {
  final AccountRepository _repository;
  AccountUsecase(this._repository);
  
  Future<({List<AccountOrdersDataEntities>? data , String? errorMassage})> cancelMyOrder({required String id, required String productId}) {
    return _repository.cancelMyOrder(id: id, productId: productId);
  }

  
  Future<({List<AccountOrdersDataEntities>? data , String? errorMassage})> deleteOrderHistory({required String id, required String productId}) {
    return _repository.deleteOrderHistory(id: id,productId: productId);
  }

  
  Future<({List<AccountOrdersDataEntities>? data , String? errorMassage})> getMyOrderHistory({required String id}) {
    return _repository.getMyOrderHistory(id: id);
  }
}