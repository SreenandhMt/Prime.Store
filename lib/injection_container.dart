import 'package:get_it/get_it.dart';
import 'package:main_work/features/account/data/data_sources/remote/remote_data_source.dart';
import 'package:main_work/features/account/data/repositories/account_repository.dart';
import 'package:main_work/features/account/domain/repositories/account_repository.dart';
import 'package:main_work/features/account/domain/usecase/account_usecase.dart';
import 'package:main_work/features/auth/data/data_sources/remote/auth_data_sources.dart';
import 'package:main_work/features/auth/data/repositories/auth_repository.dart';
import 'package:main_work/features/auth/domain/repositories/auth_repository.dart';
import 'package:main_work/features/auth/domain/usecase/auth_usecase.dart';
import 'package:main_work/features/auth/presentaion/bloc/bloc/auth_bloc.dart';
import 'package:main_work/features/buying/data/data_sources/remote_data_source.dart';
import 'package:main_work/features/buying/data/repositories/repository.dart';
import 'package:main_work/features/buying/domain/repositories/repository.dart';
import 'package:main_work/features/buying/domain/usecase/usecase.dart';
import 'package:main_work/features/buying/presentaion/bloc/buying_bloc.dart';
import 'package:main_work/features/home/data/data_sources/remote/home_data_sources.dart';
import 'package:main_work/features/home/data/repositories/home_repository.dart';
import 'package:main_work/features/home/domain/repositories/home_repository.dart';
import 'package:main_work/features/home/domain/usecase/home_usecase.dart';
import 'package:main_work/features/home/presentation/bloc/home_bloc.dart';
import 'package:main_work/features/notification/data/data_sources/data_source.dart';
import 'package:main_work/features/notification/data/repositories/repository.dart';
import 'package:main_work/features/notification/domain/repositories/repository.dart';
import 'package:main_work/features/notification/domain/usecase/usecase.dart';
import 'package:main_work/features/notification/presentaion/bloc/notification_bloc.dart';

import 'features/account/presentaion/bloc/order_list/order_list_bloc.dart';


final sl = GetIt.instance;

Future<void> initializeDependencies()async{
  sl.registerSingleton<AuthDataSource>(AuthDataSource());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImp(sl()));
  sl.registerSingleton<AuthUsecase>(AuthUsecase(sl()));
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl()));

  sl.registerSingleton<HomeDataSources>(HomeDataSources());
  sl.registerSingleton<HomeRepository>(HomeRepositoryImp(sl()));
  sl.registerSingleton<HomeUsecase>(HomeUsecase(sl()));
  sl.registerFactory<HomeBloc>(() => HomeBloc(sl()));

  sl.registerSingleton<NotificationDataSource>(NotificationDataSource());
  sl.registerSingleton<NotificationRepository>(NotificationRepositoryImp(sl()));
  sl.registerSingleton<NotificationUsecase>(NotificationUsecase(sl()));
  sl.registerFactory<NotificationBloc>(() => NotificationBloc(sl()));

  sl.registerSingleton<BuyingDataSource>(BuyingDataSource());
  sl.registerSingleton<BuyingRepository>(BuyingRepositoryImp(sl()));
  sl.registerSingleton<BuyingUsecase>(BuyingUsecase(sl()));
  sl.registerFactory<BuyingBloc>(() => BuyingBloc(sl()));

  sl.registerSingleton<AccountRemoteDataSource>(AccountRemoteDataSource());
  sl.registerSingleton<AccountRepository>(AccountRepositoryImp(sl()));
  sl.registerSingleton<AccountUsecase>(AccountUsecase(sl()));
  sl.registerFactory<OrderListBloc>(() => OrderListBloc(sl()));
}