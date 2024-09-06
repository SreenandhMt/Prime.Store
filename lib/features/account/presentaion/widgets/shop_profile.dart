import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:main_work/features/account/presentaion/widgets/account_page_product.dart';
import 'package:main_work/features/home/domain/entities/home_entitie.dart';


FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ShopProfileremovethis extends StatefulWidget {
  const ShopProfileremovethis({
    Key? key,
    required this.data,
  }) : super(key: key);
  final List<HomeDataEntities> data;

  @override
  State<ShopProfileremovethis> createState() => _ShopProfileremovethisState();
}

class _ShopProfileremovethisState extends State<ShopProfileremovethis> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getShopData(),
      builder: (context,snap) {
        if(snap.data==null)
        {
          return const CircularProgressIndicator();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(radius: 50,backgroundImage: NetworkImage(snap.data!["shopName"]??""),),
            const SizedBox(height: 10),
            Text(snap.data!["shopName"]??"",style: GoogleFonts.aBeeZee(),),
            const SizedBox(height: 24),
            const Divider(height: 1,color: Colors.black26,),
            const Row(
              children: [
                SizedBox(width: 10,),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                            'Orders Info (0)',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height:40),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 1,color: Colors.black26,),
            const SizedBox(height:20),
            const Row(
              children: [
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                          'Store Address',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text('Sreenandh MT'),
                        Text('Para kadavu kadavathur Road, Thalassery'),
                        Text('Kadavathur, Mundathode,'),
                        Text('Kadavathur East LP School, Kannur, Kerala'),
                        Text('670676'),
                        SizedBox(height: 10),
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
              children: List.generate(widget.data.length, (index) =>  ProductWidgetForAccountPage(data: widget.data[index]),),
            )
          ],
        );
      }
    );
  }
  
  Future<Map<String,dynamic>?> getShopData()async{
    try {
       _firestore.collection("shop").doc(_auth.currentUser!.uid).collection("more_data").doc("address").get().then((value) => value.data()!,);
       return _firestore.collection("shop").doc(_auth.currentUser!.uid).get().then((value) => value.data()!,);
    } catch (e) {
      print(e);
    }
  }
}