import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_work/features/buying/presentaion/blocs/bloc/confrom_bloc.dart';

import 'package:main_work/features/cart/domain/entities/cart_entities.dart';
import 'package:main_work/main.dart';

import '../../../cart/presentaion/bloc/cart_bloc.dart';
import '../../../home/data/module/home_module.dart';
import '../../../home/domain/entities/home_entitie.dart';

class OrderConform extends StatefulWidget {
  const OrderConform({
    Key? key,
    this.data,
    this.cart,
  }) : super(key: key);
  final HomeDataEntities? data;
  final List<CartEntities>? cart;

  @override
  State<OrderConform> createState() => _OrderConformState();
}

class _OrderConformState extends State<OrderConform> {
  bool done = false;
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfromBloc, ConfromState>(
      builder: (context, state) {
        if (state is SuccessPayment) {
          if (state.removeCartData != null) {
            log("removed");
            for (var data in state.removeCartData!) {
              context
                  .read<CartBloc>()
                  .add(CartDeleteData(productId: data.productId!));
              context
                  .read<ConfromBloc>()
                  .add(ClearData());
            }
          }
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 2, 130, 8),
            body: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.white,
                    child: Icon(
                      color: Colors.green,
                      Icons.done_outline_rounded,
                      size: 60,
                    ),
                  ),
                  Text(
                    "Done",
                    style: GoogleFonts.aDLaMDisplay(fontSize: 18),
                  )
                ],
              ),
            ),
          );
        }
        if (state is FaildPayment) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 187, 6, 6),
            body: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.white,
                    child: Icon(
                      color: Colors.red,
                      Icons.close_rounded,
                      size: 60,
                    ),
                  ),
                  Text(
                    "Faild",
                    style: GoogleFonts.aDLaMDisplay(fontSize: 18),
                  )
                ],
              ),
            ),
          );
        }
        return const Scaffold(
            body: Center(
                child: CircularProgressIndicator(
          color: Colors.green,
        )));
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void init() async {
    try {
      if (widget.data != null) {
      context
          .read<ConfromBloc>()
          .add(OrderPlace(data: HomeData.formjson(widget.data!.map!)));
    } else if (widget.cart != null) {
      final cart = widget.cart;
      context
            .read<ConfromBloc>()
            .add(OrderCartProdecuts(data: cart!));
    }
    } catch (e) {
     log(e.toString()); 
    }
    //  await Future.delayed(const Duration(seconds: 5),() => Navigator.of(context).pop(),);
  }
}
