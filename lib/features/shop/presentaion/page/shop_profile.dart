import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:main_work/features/account/presentaion/widgets/account_page_product.dart';
import 'package:main_work/features/shop/presentaion/bloc/bloc/shop_info_bloc.dart';

import '../widgets/shop_order_widget.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ShopProfile extends StatefulWidget {
  const ShopProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<ShopProfile> createState() => _ShopProfileState();
}

class _ShopProfileState extends State<ShopProfile> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopInfoBloc, ShopInfoState>(
        listener: (context, state) {},
        builder: (context, state) {
          if(state is SelledProdects)
          {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(radius: 50,backgroundImage: NetworkImage(state.shopData["image"]??""),),
            const SizedBox(height: 10),
            Text(state.shopData["shopName"]??"",style: GoogleFonts.aBeeZee(),),
            const SizedBox(height: 24),
            const Divider(height: 1,color: Colors.black26,),
            Row(
              children: [
                const SizedBox(width: 10,),
                Text(
                      'Orders Info (${state.ordersData.length})',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
              ],
            ),
            if(state.ordersData.isEmpty)
                        const SizedBox(height:40)
                        else
                        Column(
                          children: List.generate(state.ordersData.length, (index) => ShopOrderSummary(data:state.ordersData[index],)),
                        ),
            const Divider(height: 1,color: Colors.black26,),
            const SizedBox(height:20),
            Row(
              children: [
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                          'Store Address',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        
                        Text(state.shopAddress.address1??""),
                        Text(state.shopAddress.address2??""),
                        Text('${state.shopAddress.landmark}, ${state.shopAddress.city}, ${state.shopAddress.state}'),
                        Text(state.shopAddress.postcode??""),
                        const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
            const Divider(height: 1,color: Colors.black26,),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text(
                                'Products',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const Expanded(child: SizedBox()),
                              TextButton(onPressed: (){}, child: const Text("Sell Product"))
                ],
              ),
            ),
            const SizedBox(height: 10),
             Wrap(
              children: List.generate(state.data.length, (index) =>  ProductWidgetForAccountPage(data: state.data[index]),),
            ),
            Row(
              children: [
                const SizedBox(width: 10,),
                Text(
                      'Orders History (${state.ordersData.length})',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
              ],
            ),
            // if(state.ordersData.isEmpty)
            //             SizedBox(height:40)
            //             else
            //             Column(
            //               children: List.generate(state.ordersData.length, (index) => ShopOrderSummary(data:state.ordersData[index],)),
            //             ),
          ],
        );
          }else if(state is NoData){
            return Center(child: Text("Create Shop"));
          } else{
            return const Center(child: CircularProgressIndicator(),);
          }
        }
        );
  }
}