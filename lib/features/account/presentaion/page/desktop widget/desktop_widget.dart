
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:main_work/features/account/presentaion/bloc/bloc/account_bloc.dart';
import 'package:main_work/features/cart/presentaion/pages/cart_page.dart';
import 'package:main_work/features/notification/presentaion/page/notification_page.dart';
import 'package:main_work/features/selling/selling_page.dart';

import '../../../../../core/theme/themes.dart';
import '../../../../../main.dart';
import '../../../../home/data/module/home_module.dart';
import '../../../../home/presentation/pages/home_page.dart';
import '../../../../home/presentation/widgets/home_widgets.dart';
import '../../../../home/presentation/widgets/info_widget.dart';
import '../../../../home/presentation/widgets/search_page.dart';
import '../../../../shop/presentaion/bloc/bloc/shop_info_bloc.dart';
import '../../../../shop/presentaion/page/shop_profile.dart';
import '../../widgets/address_card.dart';
import '../../widgets/order_summary.dart';
import '../../widgets/profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
    required this.pageNumber,
  }) : super(key: key);
  final int? pageNumber;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool opened=false;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    context.read<ShopInfoBloc>().add(GetSelledDatas());
    context.read<AccountBloc>().add(GetOrderList());
    if(widget.pageNumber==null)
    {
      return Center(child: TextButton(onPressed: () {
        context.go("/Settings/0");
      },child: const Text("Page Not Found Go Back"),),);
    }
        return Scaffold(
          body: ListView(
            children: [
              const SizedBox(height: 10),
              appBarCusttom(size,context),
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
                            _buildMenuItem('Profile', widget.pageNumber==0,0),
                            _buildMenuItem('Shop Info', widget.pageNumber==1,1),
                            _buildMenuItem('My Orders', widget.pageNumber==2,2),
                            _buildMenuItem('My Wishlist', widget.pageNumber==3,3),
                            _buildMenuItem('Addresses', widget.pageNumber==4,4),
                            _buildMenuItem('Sell Product', widget.pageNumber==5,5),
                            _buildMenuItem('Cart/Bag', widget.pageNumber==6,6),
                            _buildMenuItem('Notification', widget.pageNumber==7,7),
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
                              if(widget.pageNumber == 3)
                              {
                                return Wrap(
                                  children: List.generate(
                                      state.favoriteData.length,
                                      (index) => ProductWidget(
                                            data: HomeData.formjson(
                                                state.favoriteData[index].map!),
                                          )),
                                );
                              }else if(widget.pageNumber == 5){
                                return const SellingPage();
                              }else if(widget.pageNumber == 2){
                                return Column(
                                    children: List.generate(
                                        state.ordersData.length,
                                        (index) => OrderSummary(
                                            data: state.ordersData[index])),
                                  );
                              }else if(widget.pageNumber==4){
                                return const AddressCard();
                              }else if(widget.pageNumber==6)
                              {
                                return const ScreenCartPage();
                              }else if(widget.pageNumber==7)
                              {
                                return const ScreenNotification();
                              }else if(widget.pageNumber==1)
                              {
                                return 
                                      const ShopProfile();
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
              const FooterScreen(),
            ],
          ),
        );
  }

  Widget appBarCusttom(Size size,BuildContext context){
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
                        context.go("/Settings/3");
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
                        context.go("/Settings/6");
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
        onTap: () => context.go("/Settings/$index"),
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

