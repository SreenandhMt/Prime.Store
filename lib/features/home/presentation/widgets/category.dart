
import 'package:flutter/material.dart';

import '../../../../bottom_navigation/bottom_navigation.dart';
import '../../../../main.dart';
Size? _size;

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    _size=MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).colorScheme.scrim,
      height: _size!.width*0.3,
      width: _size!.width*1,
      child: _size!.width>1000?
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(onTap: (){},child: card(icon: Icons.local_offer_rounded,name: "OFFERS")),
          GestureDetector(onTap: ()=>value.value=3,child: card(icon: Icons.shopping_cart_outlined,name: "CART")),
          GestureDetector(onTap: ()=>value.value=2,child: card(icon: Icons.favorite_border_rounded,name: "FAVORITS")),
          GestureDetector(onTap: ()=>value.value=2,child: card(icon: Icons.local_activity_outlined,name: "COUPONS")),
          GestureDetector(onTap: ()=>value.value=2,child: card(icon: Icons.add_business_outlined,name: "SELL")),
        ],
      )
      :
      ListView(
        scrollDirection: Axis.horizontal,
        children: [
          GestureDetector(onTap: (){},child: card(icon: Icons.local_offer_rounded,name: "OFFERS")),
          GestureDetector(onTap: ()=>value.value=3,child: card(icon: Icons.shopping_cart_outlined,name: "CART")),
          GestureDetector(onTap: ()=>value.value=2,child: card(icon: Icons.favorite_border_rounded,name: "FAVORITS")),
          GestureDetector(onTap: ()=>value.value=2,child: card(icon: Icons.local_activity_outlined,name: "COUPONS")),
          GestureDetector(onTap: ()=>value.value=2,child: card(icon: Icons.add_business_outlined,name: "SELL")),
        ],
      ),
    );
  }

  Widget card({required String name,required IconData icon}){
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(margin: const EdgeInsets.only(top: 1.5,left: 1.5),decoration: BoxDecoration(color: theme.brightness == Brightness.dark?const Color.fromARGB(255, 74, 112, 75):Colors.yellow,borderRadius: BorderRadius.circular(7)),height: _size!.width<=1000? _size!.width*0.147: 100,width: _size!.width<=1000? _size!.width*0.147: 100,child: Icon(icon,color: Colors.grey.shade700,size: 35,)),
              Container(margin: const EdgeInsets.only(top: 0.8,left: 0.9),decoration: BoxDecoration(color: theme.brightness == Brightness.dark? Color.fromARGB(255, 171, 220, 65): const Color.fromARGB(255, 74, 112, 75),borderRadius: BorderRadius.circular(7)),height:  _size!.width<=1000? _size!.width*0.147: 100,width:  _size!.width<=1000? _size!.width*0.147: 100,child: Icon(icon,color: Colors.grey.shade700,size: 35,)),
              Container(decoration: BoxDecoration(color: Colors.grey.shade300,borderRadius: BorderRadius.circular(7)),height: _size!.width<=1000? _size!.width*0.14: 97,width:_size!.width<=1000? _size!.width*0.14: 97,child: Icon(icon,color: Colors.grey.shade700,size: 35,)),
            ],
          ),
          const SizedBox(height: 5,),
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1.7,left: 1.7),
                child: Text(name,style:  TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: theme.brightness == Brightness.dark?Colors.green:Colors.yellow),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 1,left: 1),
                child: Text(name,style:  TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: theme.brightness == Brightness.dark?Colors.black:Colors.purpleAccent),),
              ),
              Text(name,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: theme.brightness == Brightness.dark?Colors.white:theme.secondary),),
            ],
          )
        ],
      ),
    );
  }
}