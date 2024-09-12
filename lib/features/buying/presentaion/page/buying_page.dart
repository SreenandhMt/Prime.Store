
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:main_work/features/account/presentaion/bloc/bloc/account_bloc.dart';
import 'package:main_work/features/auth/presentaion/page/auth_page.dart';
import 'package:main_work/features/buying/presentaion/widget/desktop_view.dart';
import 'package:main_work/features/buying/presentaion/widget/mobile_view.dart';

import '../../../home/domain/entities/home_category_entities.dart';
import '../blocs/buying_bloc/buying_bloc.dart';
import '/features/home/domain/entities/home_entitie.dart';
import '/main.dart';

const divider = Padding(
  padding: EdgeInsets.all(8.0),
  child: Divider(
    height: 1,
    color: Color.fromARGB(255, 97, 97, 97),
  ),
);

class BuyingPage extends StatelessWidget {
  const BuyingPage({
    Key? key,
    this.id
  }) : super(key: key);
  final String? id;

  @override
  Widget build(BuildContext context) {
    context
        .read<BuyingBloc>()
        .add(GetProductInfo(noData: id!=null,productId: id!));
    final size = MediaQuery.of(context).size;
    if(size.width>=1000)
    {
      return DesktopViewBuyingScreen(id: id);
    }else{
      return MobileViewBuyingScreen(id: id!);
    }
    
  }
  
  
}

class BuyingPageAppBar extends StatelessWidget {
  const BuyingPageAppBar({
    Key? key,
    required this.homeData,
    required this.favoritStatus,
  }) : super(key: key);
  final HomeDataEntities homeData;
  final bool favoritStatus;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<BuyingBloc, BuyingState>(
      builder: (context, state) {
        return Row(
          children: [
            IconButton(
                onPressed: ()=>context.go("/"),
                icon: const Icon(
                  Icons.navigate_before,
                  size: 35,
                )),
            const SizedBox(
              width: 10,
            ),
            Text(
              "",
              style: TextStyle(
                  color: theme.tertiary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const Expanded(child: SizedBox()),
            if (state is BuyingPageState)
              IconButton(
                  onPressed: () {
                    if(FirebaseAuth.instance.currentUser==null)
                    {
                      showDialog(context: context, builder: (context) => Dialog(child: SizedBox(width: size.width>=1000?size.width*0.3:size.width*0.6,child: const AuthGate(),),),);
                      return;
                    }
                    favoritStatus
                        ? context
                            .read<AccountBloc>()
                            .add(DeleteData(productId: homeData.productId!))
                        : context
                            .read<AccountBloc>()
                            .add(AddData(map: homeData.map!));
                    context
                        .read<BuyingBloc>()
                        .add(GetProductInfo(productId: homeData.productId!));
                  },
                  icon: Icon(
                      favoritStatus
                          ? Icons.favorite_rounded
                          : Icons.favorite_outline_rounded,
                      size: 30,
                      color:
                          favoritStatus ? Colors.red : theme.error))else IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_outline_rounded,
                      size: 30)),
            const SizedBox(
              width: 10,
            ),
          ],
        );
      },
    );
  }
}

