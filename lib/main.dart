import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:main_work/core/keys/key.dart';
import 'package:main_work/core/theme/themes.dart';
import 'package:main_work/features/account/presentaion/bloc/bloc/account_bloc.dart';
import 'package:main_work/features/account/presentaion/bloc/selling/sell_bloc.dart';
import 'package:main_work/features/account/presentaion/page/account_page.dart';
import 'package:main_work/features/account/presentaion/page/desktop%20widget/desktop_widget.dart';
import 'package:main_work/features/auth/presentaion/bloc/bloc/auth_bloc.dart';
import 'package:main_work/features/buying/presentaion/blocs/bloc/confrom_bloc.dart';
import 'package:main_work/features/buying/presentaion/blocs/buying_bloc/buying_bloc.dart';
import 'package:main_work/features/buying/presentaion/page/buying_page.dart';
import 'package:main_work/features/cart/presentaion/bloc/cart_bloc.dart';
import 'package:main_work/features/home/domain/entities/home_entitie.dart';
import 'package:main_work/features/home/presentation/bloc/home_bloc.dart';
import 'package:main_work/features/shop/presentaion/bloc/bloc/shop_info_bloc.dart';
import 'package:main_work/firebase_options.dart';
import 'package:main_work/injection_container.dart';

import 'bottom_navigation/bottom_navigation.dart';
import 'features/notification/presentaion/bloc/notification_bloc.dart';

late ColorScheme theme;

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return BottomNavigation();
      },
    ),
     GoRoute(
          path: '/Buy/:id',
          builder: (BuildContext context, GoRouterState state) {
            return BuyingPage(id: state.pathParameters["id"],);
          },
        ),
        GoRoute(
          path: '/Settings/:page',
          builder: (BuildContext context, GoRouterState state) {
            return ProfileScreen(pageNumber: int.tryParse(state.pathParameters["page"]!),);
          },
        ),
  ],
);

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
    theme = darkTheme.colorScheme;
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
        BlocProvider<ShopInfoBloc>(
          create: (context) => ShopInfoBloc(),
        ),
        BlocProvider<AccountBloc>(
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
      ],
      child: MaterialApp.router(
        title: 'Prime Store',
        darkTheme: darkTheme,
        theme: lightTheme,
        routerConfig: _router,
      ),
    );
  }
}