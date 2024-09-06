import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:main_work/features/account/presentaion/bloc/bloc/account_bloc.dart';
import 'package:main_work/features/cart/presentaion/pages/cart_page.dart';
import 'package:main_work/features/notification/presentaion/page/notification_page.dart';
import 'package:main_work/features/selling/selling_page.dart';

import '../../../../../bottom_navigation/bottom_navigation.dart';
import '../../../../../core/theme/themes.dart';
import '../../../../../main.dart';
import '../../../../auth/presentaion/page/auth_page.dart';
import '../../../../home/data/module/home_module.dart';
import '../../../../home/presentation/pages/home_page.dart';
import '../../../../home/presentation/widgets/home_widgets.dart';
import '../../../../search/pages/search_page.dart';
import '../../../../shop/presentaion/bloc/bloc/shop_info_bloc.dart';
import '../../../../shop/presentaion/page/shop_profile.dart';
import '../../widgets/address_card.dart';
import '../../widgets/order_summary.dart';
import '../../widgets/profile_widget.dart';
 int currentIndex = 0;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
    this.pageNumber,
  }) : super(key: key);
  final int? pageNumber;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    currentIndex = widget.pageNumber??currentIndex;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
     return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  // shape: Border.all(),
                  child: SizedBox(
                      width: size.width <= 1000
                          ? size.width * 0.6
                          : size.width * 0.3,
                      child: AuthGate()),
                ),
              );
            },
          );
          return Scaffold(appBar:AppBar(title: Text("Go back"),), body:  SizedBox());
        }
        context.read<ShopInfoBloc>().add(GetSelledDatas());
    context.read<AccountBloc>().add(GetOrderList());
        return Scaffold(
          body: ListView(
            children: [
              const SizedBox(height: 10),
              AppBarCusttom(size,context),
              const SizedBox(height: 20),
              const Divider(height: 1,color: Colors.black26,),
              Center(
                child: SizedBox(
                  width: size.width*0.7,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width*0.15,
                        decoration: const BoxDecoration(border: Border(right: BorderSide(width: 0.5,color: Colors.black26))),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildMenuItem('Profile', currentIndex==0,0),
                            _buildMenuItem('Shop Info', currentIndex==1,1),
                            _buildMenuItem('My Orders', currentIndex==2,2),
                            _buildMenuItem('My Wishlist', currentIndex==3,3),
                            _buildMenuItem('Addresses', currentIndex==4,4),
                            _buildMenuItem('Sell Product', currentIndex==5,5),
                            _buildMenuItem('Cart/Bag', currentIndex==6,6),
                            _buildMenuItem('Notification', currentIndex==7,7),
                          ],
                        ),
                      ),
                      Expanded(child: SizedBox(
                                width: 400,

                        child: BlocConsumer<AccountBloc, AccountState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            if(state is AccountInitial)
                            {
                              return const Center(child: CircularProgressIndicator(),);
                            }
                            if (state is GetAccountDatas) {
                              if(currentIndex == 3)
                              {
                                return Wrap(
                                  children: List.generate(
                                      state.favoriteData.length,
                                      (index) => ProductWidget(
                                            data: HomeData.formjson(
                                                state.favoriteData[index].map!),
                                          )),
                                );
                              }else if(currentIndex == 5){
                                return SellingPage();
                              }else if(currentIndex == 2){
                                return Column(
                                    children: List.generate(
                                        state.ordersData.length,
                                        (index) => OrderSummary(
                                            data: state.ordersData[index])),
                                  );
                              }else if(currentIndex==4){
                                return const AddressCard();
                              }else if(currentIndex==6)
                              {
                                return ScreenCartPage();
                              }else if(currentIndex==7)
                              {
                                return ScreenNotification();
                              }else if(currentIndex==1)
                              {
                                return 
                                      ShopProfile();
                              }else{
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ProfileWidget(profile: state.profile!,),
                                );
                              }
                          }else{
                            return const SizedBox();
                          }
                          }
                        ),
                      )),
                      
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50,),
              const Divider(height: 1,color: Colors.black26,),
              const SizedBox(height: 10,),
              FooterScreen(),
            ],
          ),
        );
      }
    );
  }

  Widget AppBarCusttom(Size size,BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  width10,
                  SizedBox(
                    child: Center(child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:4,top: 4),
                        child: Text("STORE",style: textTheme(size.width<=1000?size.width*0.06:size.width*0.027,theme.brightness == Brightness.dark?Colors.green:Colors.yellow)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3,top: 3),
                        child: Text("STORE",style: textTheme( size.width<=1000?size.width*0.06:size.width*0.027,Colors.pinkAccent)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2,top: 2),
                        child: Text("STORE",style: textTheme(size.width<=1000?size.width*0.06:size.width*0.027,theme.brightness== Brightness.dark?Colors.green:Colors.deepPurple)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 1,top: 1),
                        child: Text("STORE",style: textTheme(size.width<=1000?size.width*0.06:size.width*0.027,Colors.black)),
                      ),
                      Text("STORE",style: textTheme(size.width<=1000?size.width*0.06:size.width*0.027,theme.brightness == Brightness.dark?Colors.white:theme.secondary)),
                    ],
                  ),),),
                  const Expanded(child: SizedBox()),
                  LimitedBox(
                      maxWidth: (size.width * 0.45),
                      maxHeight: 100,
                      child: CupertinoSearchTextField(
                        keyboardType: TextInputType.none,
                        padding: const EdgeInsets.all(15),
                        itemSize: 25,
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SearchPage(),)),
                      )),
                  const Expanded(child: SizedBox()),
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: (){
                      setState(() {
                        currentIndex = 3;
                      });
                    },
                    icon: const Icon(
                      Icons.favorite,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                  width10,
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: (){
                      setState(() {
                        currentIndex = 6;
                      });
                    },
                    icon: const Icon(
                      Icons.shopping_bag_rounded,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                  width10,
                ],
              );
  }

  Widget _buildMenuItem(String title, bool isSelected,index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: InkWell(
        onTap: () => setState(() {
          currentIndex = index;
        }),
        child: Row(
          children: [
            if (isSelected)
              Container(
                width: 3,
                height: 20,
                color: Colors.red,
              ),
            if (isSelected)
              const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? null: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  
}

