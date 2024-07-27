import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:main_work/features/cart/domain/entities/cart_entities.dart';

import '../../../cart/presentaion/bloc/cart_bloc.dart';
import '../../../home/data/module/home_module.dart';
import '../../../home/domain/entities/home_entitie.dart';
import '../bloc/buying_bloc.dart';

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
    if (!done)
    {
      return const Scaffold(
          body: Center(
              child: CircularProgressIndicator(
        color: Colors.green,
      )));
    }
    return const Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Icon(
              Icons.verified,
              color: Colors.green,
              size: 100,
            ),
          ],
        ),
      ),
    );
  }

  void init() async {
    if (widget.data != null) {
      context
          .read<BuyingBloc>()
          .add(OrderPlace(data: HomeData.formjson(widget.data!.map!)));
    } else if (widget.cart != null) {
      final cart = widget.cart;
      for (var data in cart!) {
        context
            .read<BuyingBloc>()
            .add(OrderPlace(data: HomeData.formjson(data.map!)));
        context
            .read<CartBloc>()
            .add(CartDeleteData(productId: data.productId!));
      }
    }
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
      done = true;
    });
    //  await Future.delayed(const Duration(seconds: 5),() => Navigator.of(context).pop(),);
  }
}
