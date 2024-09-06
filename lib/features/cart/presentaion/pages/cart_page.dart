import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_work/features/cart/presentaion/widgets/cart_product_widget.dart';

import '/features/cart/presentaion/bloc/cart_bloc.dart';
import '/main.dart';

import '../../../../core/theme/themes.dart';

ValueNotifier totalPrice = ValueNotifier(0.0);

class ScreenCartPage extends StatelessWidget {
  const ScreenCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        if(state is CartData&&state.cartProducts.isEmpty)
        {
          return Center(
                child: Text(
                  "No data",
                  style: mainAppTextTheme(14),
                ),
              );
        }
        if(size.width>=1000)
        {
          return Column(
            children: [
              if(state is CartData)
              Wrap(
                children: List.generate(state.cartProducts.length, (index) {
                  if(index==0)
                  {
                    totalPrice.value=0;
                  }
                    totalPrice.value = totalPrice.value + state.cartProducts[index].map!["price"];
                    return Padding(
                        padding: const EdgeInsets.all(1),
                        child: CartProductWidget(
                          data: state.cartProducts[index],
                        ));
                  }),
              ),
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
                              // showModalBottomSheet(isDismissible: false,context: context, builder: (context) => LocationRequest(cart: state.cartProducts,),);
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
          );
        }
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
                          child: CartProductWidget(
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
                              // showModalBottomSheet(isDismissible: false,context: context, builder: (context) => LocationRequest(cart: state.cartProducts,),);
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


