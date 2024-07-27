import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/buying/presentaion/widget/product_images.dart';
import '/features/home/domain/entities/home_entitie.dart';
import '/features/home/presentation/pages/home_page.dart';
import '/features/home/presentation/widgets/home_widgets.dart';
import '/main.dart';

import '../../../../core/colors/colors.dart';
import '../../../../widgets/location/location_request.dart';
import '../../../../widgets/rating/rating_bar.dart';
import '../../../account/presentaion/bloc/favorit/favorit_bloc.dart';
import '../../../cart/presentaion/bloc/cart_bloc.dart';
import '../bloc/buying_bloc.dart';
import '../widget/prodect_text.dart';

Size size = const Size(0, 0);
const divider = Padding(
  padding: EdgeInsets.all(8.0),
  child: Divider(
    height: 1,
    color: Color.fromARGB(255, 97, 97, 97),
  ),
);

class BuyingPage extends StatelessWidget {
  const BuyingPage({
    Key? key,
    required this.homeData,
    this.dataList,
  }) : super(key: key);
  final HomeDataEntities homeData;
  final List<HomeDataEntities>? dataList;

  @override
  Widget build(BuildContext context) {
    log(homeData.highlights.toString());
    context
        .read<BuyingBloc>()
        .add(GetFavoritState(productId: homeData.productId!));
    size = MediaQuery.of(context).size;
    final themeCopy = theme;
    return BlocBuilder<BuyingBloc, BuyingState>(
      builder: (context, state) {
        return Scaffold(
                body: SafeArea(
                  child: ListView(
                    children: [
                      // appbar
                      BuyingPageAppBar(homeData: homeData),

                      //images
                      BuyingPageImages(homeData: homeData),

                      height10,

                      Container(
                          decoration: BoxDecoration(
                              color: theme.background,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BuyingTexts(homeData: homeData),
                              ListTile(
                                leading: const CircleAvatar(
                                  backgroundColor: Colors.grey,
                                ),
                                title: const Text(
                                  "Seller Name",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: const Text(
                                  "100 Follows",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal),
                                ),
                                trailing: Container(
                                  height: 30,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(child: Text("Follow")),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              //product about
                              productDelatels(size),

                              // if (homeData.colorList != null &&
                              //     homeData.colorList!.isNotEmpty &&
                              //     homeData.sizeList!.isNotEmpty &&
                              //     homeData.sizeList != null)
                              //   ProductDatas(homeData: homeData),
                              //   height10,
                              reviewAndRating(),
                              if(dataList!=null)
                              moreDatas(size),
                    ],
                  ),
                  )],
                ),),
                bottomNavigationBar: Container(
                  decoration: BoxDecoration(color: theme.background),
                  padding: const EdgeInsets.all(7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "₹ ${homeData.map!["price"] ?? ""}",
                        style: TextStyle(
                            color: themeCopy.secondary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const Expanded(child: SizedBox()),
                      if (state is BuyingPageState)
                        GestureDetector(
                          onTap: () async {
                            state.cartListAdded
                                ? context.read<CartBloc>().add(CartDeleteData(
                                    productId: homeData.productId!))
                                : context
                                    .read<CartBloc>()
                                    .add(CartAddData(map: homeData.map!));
                            context.read<BuyingBloc>().add(GetFavoritState(
                                productId: homeData.productId!));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: themeCopy.secondary,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8))),
                            width: 125,
                            height: 55,
                            child: Center(
                              child: Text(
                                state.cartListAdded
                                    ? "Remove Cart"
                                    : "Add Cart",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: mainColor(context)),
                              ),
                            ),
                          ),
                        ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            isDismissible: false,
                            context: context,
                            builder: (context) => LocationRequest(
                              home: homeData,
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: themeCopy.tertiary,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8))),
                          width: 145,
                          height: 55,
                          child: const Center(
                            child: Text(
                              "Buy",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
  }

  Widget infoText(Size size,String text){
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 6,right: 5,top: 5,bottom: 5),
          width: size.width*0.1,
          height: 1,
          decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(5)),
        ),
        Text(text,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
        Expanded(
          child: Container(
            height: 1,
            margin: const EdgeInsets.only(left: 5,right: 6,top: 5,bottom: 5),
            decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(5)),
          ),
        ),
      ],
    );
  }

  Widget moreDatas(Size size){
    return Column(
      children: [
        infoText(size, "More Products"),
        height10,
        Padding(
          padding: const EdgeInsets.only(left: 6),
          child: LimitedBox(
            maxWidth: size.width*0.9,
            maxHeight: size.width*0.7,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(dataList!.length, (index) => ProductWidget(data: dataList![index])),
            ),
          ),
        ),
      ],
    );
  }

  Widget reviewAndRating({List<Map<String,dynamic>>? review}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       infoText(size, "Rating and Review"),
                              height10,
                              if(homeData.map!=null&&homeData.map!["rate1"]!=null)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  width10,
                                Text(ratingText(),style: const TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  progressBar(ratingCount: "5",value: homeData.map!["rate5"].toDouble()),
                                  progressBar(ratingCount: "4",value: homeData.map!["rate4"].toDouble()),
                                  progressBar(ratingCount: "3",value: homeData.map!["rate3"].toDouble()),
                                  progressBar(ratingCount: "2",value: homeData.map!["rate2"].toDouble()),
                                  progressBar(ratingCount: "1",value: homeData.map!["rate1"].toDouble()),
                                ],
                                                              )
                              ],),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15,bottom: 6),
                                child: MaterialButton(onPressed: (){},color: Colors.green,child: const Text("Reviews"),),
                              ),
      ],
    );
  }

  Widget progressBar({
    required String ratingCount,
    required double value,
  }) {
    return Row(
      children: [
        Text(ratingCount),
        const SizedBox(
          width: 4,
        ),
        LimitedBox(
          maxWidth: 230,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: LinearProgressIndicator(
              value: (value.toInt() /topRating().toInt())*topRating(),
              minHeight: 10,
              borderRadius: BorderRadius.circular(10),
              backgroundColor: Colors.grey,
              valueColor: const AlwaysStoppedAnimation(Colors.blue),
            ),
          ),
        ),
      ],
    );
  }

  Widget productDelatels(Size size) {
    return Theme(
      data: ThemeData(brightness: theme.brightness,iconTheme: const IconThemeData(color: Colors.grey),textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.grey),)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         infoText(size, "About"),
          height10,
          const Row(
            children: [
              width10,
              Icon(Icons.shopping_cart_checkout_rounded),
              SizedBox(
                width: 6,
              ),
              Text("Free Delivery", textAlign: TextAlign.start,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
            ],
          ),
          height10,
          const Row(
            children: [
              width10,
              Icon(Icons.attach_money_outlined),
              SizedBox(
                width: 6,
              ),
              Text(
                "Cash on delivery avalable",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),
              ),
            ],
          ),
          height10,
           const Row(
            children: [
              width10,
              Icon(Icons.add_home_work_rounded),
              SizedBox(
                width: 10,
              ),
              Text(
                "In Stock",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),
              ),
            ],
          ),
          height20,
        ],
      ),
    );
  }

  double topRating() {
    dynamic top;int rateindex=1;
    for (var i = 1; i <= 5; i++) {
      if (i == 1) {
        top = homeData.map!["rate$i"];
        rateindex = i;
      } else if (homeData.map!["rate$i"] > top) {
        top = homeData.map!["rate$i"];
        rateindex = i;
      }
    }
    return top.toDouble();
  }

  String ratingText() {
    dynamic top, rateindex;
    for (var i = 1; i <= 5; i++) {
      if (i == 1) {
        top = homeData.map!["rate$i"];
        rateindex = i;
      } else if (homeData.map!["rate$i"] > top) {
        top = homeData.map!["rate$i"];
        rateindex = i;
      }
    }
    return top != null ? "$rateindex" : "";
  }
}

class BuyingPageAppBar extends StatelessWidget {
  const BuyingPageAppBar({
    Key? key,
    required this.homeData,
  }) : super(key: key);
  final HomeDataEntities homeData;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuyingBloc, BuyingState>(
      builder: (context, state) {
        return Row(
          children: [
            IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.navigate_before,
                  size: 35,
                )),
            const SizedBox(
              width: 10,
            ),
            Text(
              homeData.productName ?? "",
              style: TextStyle(
                  color: theme.tertiary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const Expanded(child: SizedBox()),
            if (state is BuyingPageState)
              IconButton(
                  onPressed: () {
                    state.favoritListAdded
                        ? context
                            .read<FavoritBloc>()
                            .add(DeleteData(productId: homeData.productId!))
                        : context
                            .read<FavoritBloc>()
                            .add(AddData(map: homeData.map!));
                    context
                        .read<BuyingBloc>()
                        .add(GetFavoritState(productId: homeData.productId!));
                  },
                  icon: Icon(
                      state.favoritListAdded
                          ? Icons.favorite_rounded
                          : Icons.favorite_outline_rounded,
                      size: 30,
                      color:
                          state.favoritListAdded ? Colors.red : theme.error)),
            const SizedBox(
              width: 10,
            ),
          ],
        );
      },
    );
  }
}

int _currentColor = 0, _currentSize = 0;

class ProductDatas extends StatefulWidget {
  const ProductDatas({
    Key? key,
    required this.homeData,
  }) : super(key: key);
  final HomeDataEntities homeData;

  @override
  State<ProductDatas> createState() => _ProductDatasState();
}

class _ProductDatasState extends State<ProductDatas> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        divider,
        const SizedBox(
          height: 30,
        ),
        if (widget.homeData.sizeList != null &&
            widget.homeData.sizeList!.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 11, bottom: 10),
                child: Text(
                  "Color",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                  children: List.generate(
                      widget.homeData.colorList!.length,
                      (index) => GestureDetector(
                            onTap: () {
                              _currentColor = index;
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: _currentColor == index ? 10 : 15,
                                  right: _currentColor == index ? 10 : 15,
                                  top: 6,
                                  bottom: 6),
                              padding: const EdgeInsets.only(
                                  left: double.infinity, top: 7, bottom: 3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ))),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        if (widget.homeData.colorList != null &&
            widget.homeData.colorList!.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 11, bottom: 10, top: 10),
                child: Text(
                  "Size",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              Wrap(
                  runSpacing: 10,
                  children: List.generate(
                      widget.homeData.sizeList!.length,
                      (index) => GestureDetector(
                            onTap: () {
                              _currentSize = index;
                              setState(() {});
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 7),
                              padding: const EdgeInsets.all(5),
                              width: 70,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: _currentSize == index
                                      ? Border.all(
                                          width: 3, color: Colors.lightGreen)
                                      : Border.all(),
                                  color: theme.tertiary,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                      widget.homeData.sizeList![index] ?? "")),
                            ),
                          ))),
            ],
          ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
