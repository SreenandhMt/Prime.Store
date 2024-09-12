
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_work/core/theme/themes.dart';
import 'package:main_work/features/account/presentaion/bloc/bloc/account_bloc.dart';
import 'package:main_work/features/account/presentaion/page/desktop%20widget/desktop_widget.dart';
import 'package:main_work/features/account/presentaion/widgets/address_card.dart';
import 'package:main_work/features/account/presentaion/widgets/order_summary.dart';
import 'package:main_work/features/account/presentaion/widgets/profile_widget.dart';
import 'package:main_work/features/home/presentation/widgets/home_widgets.dart';
import 'package:main_work/features/shop/presentaion/bloc/bloc/shop_info_bloc.dart';
import 'package:main_work/features/shop/presentaion/page/shop_profile.dart';

import '../../../shop/presentaion/page/shop_page.dart';
import '/features/auth/presentaion/page/auth_page.dart';
import '/features/home/data/module/home_module.dart';
import '/features/home/presentation/pages/home_page.dart';
import '/features/selling/selling_page.dart';

import '../../../../main.dart';

class ScreenAccount extends StatefulWidget {
  const ScreenAccount({super.key});

  @override
  State<ScreenAccount> createState() => _ScreenAccountState();
}

class _ScreenAccountState extends State<ScreenAccount>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if(size.width>=1000)
    {
      return const ProfileScreen(pageNumber: 1,);
    }
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
            context.read<ShopInfoBloc>().add(GetSelledDatas());
            context.read<AccountBloc>().add(GetOrderList());
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Account",
                style: mainAppTextTheme(20),
              ),
              backgroundColor: theme.background,
              actions: [
                IconButton(
                    onPressed: () => showModalBottomSheet(
                      isScrollControlled: true,
                          context: context,
                          builder: (context) => const ShopPage(),
                        ),
                    icon: const Icon(Icons.store)),
                width10,
                IconButton(
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    icon: const Icon(Icons.logout)),
                width10
              ],
            ),
            body: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                TabBar(
                    controller: _tabController,
                    onTap: (value) => setState(() {}),
                    physics: const NeverScrollableScrollPhysics(),
                    labelColor: Colors.green,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.greenAccent,
                    tabs: const [
                      Tab(text: 'Favorits'),
                      Tab(text: 'Orders'),
                      Tab(text: 'Store'),
                      Tab(text: 'Profile'),
                    ]),
                Expanded(
                  child: BlocConsumer<AccountBloc, AccountState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if(state is AccountInitial)
                      {
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      if (state is GetAccountDatas) {
                        return TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          children: [
                            SingleChildScrollView(
                              child: Wrap(
                                children: List.generate(
                                    state.favoriteData.length,
                                    (index) => ProductWidget(
                                          data: HomeData.formjson(
                                              state.favoriteData[index].map!),
                                        )),
                              ),
                            ),
                            ListView(
                              children: List.generate(
                                  state.ordersData.length,
                                  (index) => OrderSummary(
                                      data: state.ordersData[index])),
                            ),
                            ListView(
                              children: const [
                                ShopProfile(),
                              ],
                            ),
                            ListView(
                              children: [
                                if(state.profile!=null)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ProfileWidget(profile: state.profile!,),
                                ),
                                const AddressCard()
                              ],
                            )
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ],
            ),
            bottomNavigationBar: _tabController.index == 2 &&
                    FirebaseAuth.instance.currentUser != null
                ? FloatingActionButton(
                    onPressed: () {
                      final shopData =
                          FirebaseAuth.instance.currentUser!.displayName !=
                                  null &&
                              FirebaseAuth.instance.currentUser!.displayName!
                                  .isNotEmpty;
                      if (shopData) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SellingPage(),
                        ));
                      } else {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => const ShopPage(),
                        );
                      }
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  )
                : null,
          );
        } else {
          return const AuthGate();
        }
      },
    );
  }
}
