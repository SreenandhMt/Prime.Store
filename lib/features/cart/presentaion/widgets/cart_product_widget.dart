
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_work/features/home/data/module/home_module.dart';

import '../../../../main.dart';
import '../../../buying/presentaion/page/buying_page.dart';
import '../../domain/entities/cart_entities.dart';
import '../bloc/cart_bloc.dart';
import '../pages/cart_page.dart';

class CartProductWidget extends StatefulWidget {
  const CartProductWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final CartEntities data;

  @override
  State<CartProductWidget> createState() => _CartProductWidgetState();
}

class _CartProductWidgetState extends State<CartProductWidget> {
  int count=1;
  
  @override
  Widget build(BuildContext context) {
    dynamic price=widget.data.map!["price"]*count;
    int kprice = widget.data.map!["price"];
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width>=1000?size.width*0.4: 500,
      height: 110,
      decoration: BoxDecoration(
          color: theme.primary, borderRadius: BorderRadius.circular(1)),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                GestureDetector(onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => BuyingPage(homeData: HomeData.formjson(widget.data.map!)),)),child: Image.network(widget.data.productUrls![0],width: 100,)),
                // Container(
                //   margin: const EdgeInsets.all(10),
                //   height: 90,
                //   width: 90,
                //   decoration: BoxDecoration(
                //       color: Colors.grey,
                //       image: DecorationImage(image: NetworkImage(data.productUrls![0]),fit: BoxFit.),
                //       borderRadius: BorderRadius.circular(8)),
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.data.productName!,
                      style: const TextStyle(),
                    ),
                    Text(
                      "₹$price",
                      style: TextStyle(
                          color: theme.tertiary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 23,
                      width: 90,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                if(count<1)return;
                                count=count-1;
                                price = price+kprice;
                                totalPrice.value = totalPrice.value - kprice;
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: theme.tertiary,
                                    borderRadius: BorderRadius.circular(3)),
                                child: const Icon(Icons.remove),),
                          ),
                          const Expanded(child: SizedBox()),
                          Text(count.toString()),
                          const Expanded(child: SizedBox()),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                count=count+1;
                                price = price - kprice;
                                totalPrice.value = totalPrice.value + kprice;
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: theme.tertiary,
                                    borderRadius: BorderRadius.circular(3)),
                                child: const Icon(Icons.add)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "$kprice",
                  style: TextStyle(
                      color: theme.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              )),
          Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: ()=>context.read<CartBloc>().add(CartDeleteData(productId: widget.data.productId!)),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
              )),
        ],
      ),
    );
  }
}