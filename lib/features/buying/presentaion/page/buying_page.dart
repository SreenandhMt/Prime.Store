
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    required this.homeData,
    this.dataList,
  }) : super(key: key);
  final HomeDataEntities homeData;
  final HomeCategoryDataEntities? dataList;

  @override
  Widget build(BuildContext context) {
    context
        .read<BuyingBloc>()
        .add(GetProductInfo(productId: homeData.productId!));
    final size = MediaQuery.of(context).size;
    if(size.width>=1000)
    {
      return DesktopViewBuyingScreen(homeData: homeData,dataList: dataList);
    }else{
      return MobileViewBuyingScreen(homeData: homeData,dataList: dataList);
    }
    
  }
  
  
}

class BuyingPageAppBar extends StatelessWidget {
  const BuyingPageAppBar({
    Key? key,
    required this.homeData,
  }) : super(key: key);
  final HomeDataEntities homeData;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<BuyingBloc, BuyingState>(
      builder: (context, state) {
        return Row(
          children: [
            IconButton(
                onPressed: () => Navigator.of(context).pop(),
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
                      showDialog(context: context, builder: (context) => Dialog(child: SizedBox(width: size.width>=1000?size.width*0.3:size.width*0.6,child: AuthGate(),),),);
                      return;
                    }
                    state.favoritListAdded
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
                      state.favoritListAdded
                          ? Icons.favorite_rounded
                          : Icons.favorite_outline_rounded,
                      size: 30,
                      color:
                          state.favoritListAdded ? Colors.red : theme.error))else IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_outline_rounded,
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

