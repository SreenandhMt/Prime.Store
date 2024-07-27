import '../entities/account_orders_entities.dart';

abstract class AccountRepository {
  Future<({List<AccountOrdersDataEntities>? data , String? errorMassage})> getMyOrderHistory({required String id});
  Future<({List<AccountOrdersDataEntities>? data , String? errorMassage})> deleteOrderHistory({required String id,required String productId});
  Future<({List<AccountOrdersDataEntities>? data , String? errorMassage})> cancelMyOrder({required String id,required String productId});
  // Future<({List<AccountOrdersDataEntities>? data , String? errorMassage})> getMyOrderReturn({required String id,required String productId});
}