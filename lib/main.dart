import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:main_work/core/keys/key.dart';
import 'package:main_work/core/theme/themes.dart';
import 'package:main_work/features/account/presentaion/bloc/order_list/order_list_bloc.dart';
import 'package:main_work/features/account/presentaion/bloc/selling/sell_bloc.dart';
import 'package:main_work/features/auth/presentaion/bloc/bloc/auth_bloc.dart';
import 'package:main_work/features/buying/presentaion/blocs/bloc/confrom_bloc.dart';
import 'package:main_work/features/buying/presentaion/blocs/buying_bloc/buying_bloc.dart';
import 'package:main_work/features/cart/presentaion/bloc/cart_bloc.dart';
import 'package:main_work/features/home/presentation/bloc/home_bloc.dart';
import 'package:main_work/firebase_options.dart';
import 'package:main_work/injection_container.dart';

import 'bottom_navigation/bottom_navigation.dart';
import 'features/account/presentaion/bloc/favorit/favorit_bloc.dart';
import 'features/notification/presentaion/bloc/notification_bloc.dart';

late ColorScheme theme;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await initializeDependencies();
  Stripe.publishableKey=publishablekey;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<ConfromBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<BuyingBloc>(
          create: (context) => BuyingBloc(),
        ),
        BlocProvider<OrderListBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<NotificationBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<SellBloc>(
          create: (context) => SellBloc(),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
        BlocProvider<FavoritBloc>(
          create: (context) => FavoritBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Shout Store',
        darkTheme: darkTheme,
        theme: lightTheme,
        home:const BottomNavigation(),
      ),
    );
  }
}
