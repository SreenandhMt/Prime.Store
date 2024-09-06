import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_work/features/account/presentaion/widgets/address_adding.dart';

import 'package:main_work/features/buying/presentaion/blocs/bloc/confrom_bloc.dart';
import 'package:main_work/features/cart/domain/entities/cart_entities.dart';

import '../../../auth/presentaion/page/auth_page.dart';
import '../../../cart/presentaion/bloc/cart_bloc.dart';
import '../../../home/data/module/home_module.dart';
import '../../../home/domain/entities/home_entitie.dart';

class OrderConform extends StatefulWidget {
  const OrderConform({
    Key? key,
    this.data,
    this.cart,
    this.selectedColor,
    this.selectedSize,
    this.itemCount,
    this.cartSelectedColor,
    this.cartSelectedSize,
    this.cartItemCount,
  }) : super(key: key);
  final HomeDataEntities? data;
  final List<CartEntities>? cart;
  final String? selectedColor;
  final String? selectedSize;
  final String? itemCount;
  final List<String>? cartSelectedColor;
  final List<String>? cartSelectedSize;
  final List<String>? cartItemCount;

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
    final size = MediaQuery.of(context).size;
    return BlocBuilder<ConfromBloc, ConfromState>(
      builder: (context, state) {
        if (state is LoginRequest) {
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
          return SizedBox(
              width: double.infinity,
              height: 300,
              child: Center(
                  child: Stack(
                children: [],
              )));
        }
        if (state is AddressRequest) {
          WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  shape: Border.all(),
                  child: SizedBox(
                      child: AddressAddingPage()),
                ),
              );
            },
          );
          return SizedBox(
              width: double.infinity,
              height: 300,
              child: Center(
                  child: Stack(
                children: [],
              )));
        }
        if (state is SuccessPayment) {
          if (state.removeCartData != null) {
            for (var data in state.removeCartData!) {
              context
                  .read<CartBloc>()
                  .add(CartDeleteData(productId: data.productId!));
              context.read<ConfromBloc>().add(ClearData());
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
        context.read<ConfromBloc>().add(OrderPlace(
            data: HomeData.formjson(widget.data!.map!),
            itemCount: widget.itemCount ?? "1",
            selectedColor:
                widget.selectedColor ?? widget.data!.colorList!.first,
            selectedSize: widget.selectedSize ?? widget.data!.sizeList!.first));
      } else if (widget.cart != null) {
        final cart = widget.cart;
        context.read<ConfromBloc>().add(OrderCartProdecuts(data: cart!));
      }
    } catch (e) {
      log(e.toString());
    }
    //  await Future.delayed(const Duration(seconds: 5),() => Navigator.of(context).pop(),);
  }
}
