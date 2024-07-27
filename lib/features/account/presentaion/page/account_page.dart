import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timelines/timelines.dart';

import '/features/account/domain/entities/account_orders_entities.dart';
import '/features/account/presentaion/bloc/order_list/order_list_bloc.dart';
import '/features/account/presentaion/bloc/selling/sell_bloc.dart';
import '/features/account/presentaion/page/shop_page.dart';
import '/features/auth/presentaion/page/auth_page.dart';
import '/features/home/data/module/home_module.dart';
import '/features/home/presentation/pages/home_page.dart';
import '/features/selling/selling_page.dart';
import '/widgets/rating/rating_bar.dart';

import '../../../../main.dart';
import '../../../buying/presentaion/page/buying_page.dart';
import '../../../home/domain/entities/home_entitie.dart';
import '../bloc/favorit/favorit_bloc.dart';

class ScreenAccount extends StatefulWidget {
  const ScreenAccount({super.key});

  @override
  State<ScreenAccount> createState() => _ScreenAccountState();
}

class _ScreenAccountState extends State<ScreenAccount>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    log("inited");
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<FavoritBloc>().add(GetData());
    context.read<SellBloc>().add(GetSelledDatas());
    context.read<OrderListBloc>().add(GetOrderList());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
        backgroundColor: theme.background,
        actions: [
          IconButton(
              onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (context) => const ShopPage(),
                  ),
              icon: const Icon(Icons.store)),
          width10,
          IconButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: const Icon(Icons.logout)),
          width10
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          TabBar(
              controller: _tabController,
              onTap: (value) => setState(() {}),
              physics: const NeverScrollableScrollPhysics(),
              labelColor: Colors.green,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.greenAccent,
              tabs: const [
                Tab(text: 'Favorits'),
                Tab(text: 'Orders'),
                Tab(text: 'Coupons'),
                Tab(text: 'Sell'),
              ]),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                BlocConsumer<FavoritBloc, FavoritState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is Data) {
                      return SingleChildScrollView(
                        child: Wrap(
                          children: List.generate(
                              state.data.length,
                              (index) => ProductWidget(
                                    data: HomeData.formjson(
                                        state.data[index].map!),
                                  )),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                BlocConsumer<OrderListBloc, OrderListState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is OrderList && state.data.data != null) {
                      return ListView(
                        children: List.generate(
                            state.data.data!.length,
                            (index) =>
                                OrderWidget(data: state.data.data![index])),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                const Center(
                  child: Text('sample text for Settings Tab'),
                ),
                BlocConsumer<SellBloc, SellState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return StreamBuilder(
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (state is SelledProdects) {
                            return SingleChildScrollView(
                              child: Wrap(
                                children: List.generate(
                                    state.data.length,
                                    (index) => MyProducts(
                                          data: HomeData.formjson(
                                              state.data[index].map!),
                                        )),
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        } else {
                          return const AuthRoute();
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _tabController.index == 3 &&
              FirebaseAuth.instance.currentUser != null
          ? FloatingActionButton(
              onPressed: () {
                final shopData =
                    FirebaseAuth.instance.currentUser!.displayName != null &&
                        FirebaseAuth
                            .instance.currentUser!.displayName!.isNotEmpty;
                if (shopData) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SellingPage(),
                  ));
                } else {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const ShopPage(),
                  );
                }
              },
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            )
          : null,
    );
  }
}

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final HomeDataEntities data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width <= 500) {
      return GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BuyingPage(
            homeData: data,
          ),
        )),
        child: Container(
          margin: const EdgeInsets.all(3.5),
          width: (size.width / 2) * 0.96,
          height: (size.width) * 0.68,
          decoration: BoxDecoration(color: theme.primary),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 230,
                    ),
                    child: Image.network(data.productUrls!.first)),
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () => context
                          .read<FavoritBloc>()
                          .add(DeleteData(productId: data.productId!)),
                      icon: const Icon(Icons.delete))),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      width: (size.width / 2) * 0.95,
                      height: 80,
                      color: Theme.of(context).colorScheme.primary,
                      child: ProductText(
                        data: data,
                      ))),
            ],
          ),
        ),
      );
    } else {
      return Container(
        height: 500,
        width: 300,
        margin: const EdgeInsets.all(3.5),
        color: theme.primary,
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                width: (size.width / 2) * 0.95,
                height: 80,
                color: theme.primary,
                child: ProductText(
                  data: data,
                ))),
      );
    }
  }
}

class MyProducts extends StatelessWidget {
  const MyProducts({
    Key? key,
    required this.data,
  }) : super(key: key);
  final HomeDataEntities data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width <= 500) {
      return GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SellingPage(
            data: data,
          ),
        )),
        child: Container(
          margin: const EdgeInsets.all(3.5),
          width: (size.width / 2) * 0.96,
          height: (size.width) * 0.68,
          decoration: BoxDecoration(color: theme.primary),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 230,
                    ),
                    child: Image.network(data.productUrls!.first)),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      width: (size.width / 2) * 0.95,
                      height: 80,
                      color: Theme.of(context).colorScheme.primary,
                      child: ProductText(
                        data: data,
                      ))),
            ],
          ),
        ),
      );
    } else {
      return Container(
        height: 500,
        width: 300,
        margin: const EdgeInsets.all(3.5),
        color: theme.primary,
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                width: (size.width / 2) * 0.95,
                height: 80,
                color: theme.primary,
                child: ProductText(
                  data: data,
                ))),
      );
    }
  }
}

class ProductText extends StatelessWidget {
  const ProductText({
    Key? key,
    required this.data,
  }) : super(key: key);
  final HomeDataEntities data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.productName ?? "",
            style: TextStyle(color: theme.tertiary),
          ),
          Text(
            data.productAbout ?? "",
            style: const TextStyle(),
            maxLines: 1,
            overflow: TextOverflow.clip,
          ),
          Row(
            children: [
              Icon(
                Icons.star_rounded,
                color: Colors.yellow[600],
                size: 20,
              ),
              Text(
                "4.9|2096",
                style: TextStyle(color: theme.tertiary),
              ),
              const Expanded(child: SizedBox()),
              Text(
                "${data.map!["price"] ?? ""}",
                style: TextStyle(fontSize: 16, color: theme.secondary),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class OrderWidget extends StatefulWidget {
  const OrderWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final AccountOrdersDataEntities data;

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool clicked = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => setState(() {
        clicked = !clicked;
      }),
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
        margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BuyingPage(
                        homeData: HomeData.formjson(widget.data.map!)),
                  )),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(
                              widget.data.map!["productUrls"]!.first)),
                      color: theme.tertiary,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: size.width * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.map!["productName"] ?? "",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                      Text(
                        widget.data.map!["productAbout"] ?? "",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: theme.tertiary),
                      ),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: theme.tertiary,
                      ),
                      child: Text(widget.data.status ?? ""),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      "₹${widget.data.map!["price"] ?? "Error"}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ],
                ),
              ],
            ),
            Visibility(
              visible: clicked,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const SizedBox(
                    height: 5,
                  ),
                  FixedTimeline.tileBuilder(
                    builder: TimelineTileBuilder.connectedFromStyle(
                      contentsAlign: ContentsAlign.reverse,
                      oppositeContentsBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  text(index),
                      ),
                      connectorStyleBuilder: (context, index) =>
                          ConnectorStyle.solidLine,
                      indicatorStyleBuilder: (context, index)
                      {
                        if(widget.data.status == "Order Placed"&&index==0)
                        {
                          return IndicatorStyle.dot;
                        }
                        if(widget.data.status == "Shipping"&&index<=1)
                        {
                          return IndicatorStyle.dot;
                        }
                        if(widget.data.status == "Out for Delivery"&&index<=2)
                        {
                          return IndicatorStyle.dot;
                        }
                        if(widget.data.status == "Delivery")
                        {
                          return IndicatorStyle.dot;
                        }
                        return IndicatorStyle.outlined;
                      },
                      nodePositionBuilder: (context, index) => 0.01,
                      itemCount:  widget.data.status != "Delivery"?4:2,
                      firstConnectorStyle: ConnectorStyle.transparent,
                      lastConnectorStyle: ConnectorStyle.transparent
                    ),
                  ),
                  
                ],
              ),
            ),
            Visibility(
              visible: widget.data.status == "Delivery",
              child: Center(
                child: MaterialButton(
                  onPressed: () => showModalBottomSheet(
                      isDismissible: true,
                      showDragHandle: false,
                      context: context,
                      builder: (context) => ratingWidget(context, widget.data),
                      enableDrag: true),
                  child: const Text("review"),
                  color: Colors.green,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget text(int index) {
    if (index == 0) {
      return Text(
        "Order confiremed",
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: widget.data.status == "Order Placed"
                ? Colors.green
                : Colors.white),
      );
    }
    if (index == 1&&widget.data.status != "Delivery") {
      return Text(
        "Shipping, erpected",
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: widget.data.status == "Shipping"
                ? Colors.green
                : Colors.white),
      );
    }
    if (index == 2&& widget.data.status != "Delivery") {
      return Text(
        "Out for delivery",
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: widget.data.status == "Out for Delivery"
                ? Colors.green
                : Colors.white),
      );
    } else {
      return Text(
        "Delivery",
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: widget.data.status == "Delivery"
                ? Colors.green
                : Colors.white),
      );
    }
  }
}
