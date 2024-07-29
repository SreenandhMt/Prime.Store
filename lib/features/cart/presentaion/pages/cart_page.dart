import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_work/features/buying/presentaion/blocs/buying_bloc/buying_bloc.dart';
import 'package:main_work/features/cart/domain/entities/cart_entities.dart';

import 'package:main_work/features/cart/presentaion/bloc/cart_bloc.dart';
import 'package:main_work/main.dart';
import 'package:main_work/widgets/location/location_request.dart';

import '../../../../core/theme/themes.dart';
import '../../../buying/presentaion/page/buying_page.dart';
import '../../../home/data/module/home_module.dart';

ValueNotifier totalPrice = ValueNotifier(0.0);

class ScreenCartPage extends StatelessWidget {
  const ScreenCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>().add(CartGetData());
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if(state is CartData)
        {
          if(state.cartProducts.isEmpty)
          {
            totalPrice.value=0;
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("My Cart",style: mainAppTextTheme(20)),
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          body: Column(
            children: [
              if(state is CartData)
              Expanded(
                child: ListView(
                  children: List.generate(state.cartProducts.length, (index) {
                    if(index==0)
                    {
                      totalPrice.value=0;
                    }
                      totalPrice.value = totalPrice.value + state.cartProducts[index].map!["price"];
                      return Padding(
                          padding: const EdgeInsets.all(1),
                          child: CartWidget(
                            data: state.cartProducts[index],
                          ));
                    }),
                ),
              )
              else
              const Expanded(child: SizedBox()),
              Container(
                padding: const EdgeInsets.all(10),
                color: theme.background,
                child: Column(
                  children: [
                    Row(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: totalPrice,
                          builder: (context,v,_) {
                            final slit = totalPrice.value.toString().split(".");
                            return Text(
                              "₹${slit.first}",
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            );
                          }
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Icon(
                          Icons.info_outline,
                          size: 20,
                        ),
                        const Expanded(child: SizedBox()),
                        GestureDetector(
                            onTap: () async{
                            if(state is CartData)
                            {
                              showModalBottomSheet(isDismissible: false,context: context, builder: (context) => LocationRequest(cart: state.cartProducts,),);
                            }
                            },
                            child: Container(
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      colors: [
                                        Colors.lightGreen,
                                        Colors.green
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                child: Text(
                                  "Place Order",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CartWidget extends StatefulWidget {
  const CartWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final CartEntities data;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  int count=1;
  
  @override
  Widget build(BuildContext context) {
    dynamic price=widget.data.map!["price"]*count;
    int kprice = widget.data.map!["price"];
    return Container(
      width: 500,
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
