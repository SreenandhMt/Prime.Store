import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_work/features/buying/presentaion/page/order_confrom.dart';

import 'package:main_work/features/buying/presentaion/widget/more_product.dart';
import 'package:main_work/features/buying/presentaion/widget/product_details.dart';
import 'package:main_work/features/buying/presentaion/widget/product_images.dart';
import 'package:main_work/features/buying/presentaion/widget/product_text.dart';
import 'package:main_work/features/buying/presentaion/widget/progressbar.dart';
import 'package:main_work/features/buying/presentaion/widget/text_divider.dart';
import 'package:main_work/main.dart';

import '../../../../core/colors/colors.dart';
import '../../../cart/presentaion/bloc/cart_bloc.dart';
import '../../../home/domain/entities/home_category_entities.dart';
import '../../../home/domain/entities/home_entitie.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../selling/selling_page.dart';
import '../blocs/buying_bloc/buying_bloc.dart';
import '../page/buying_page.dart';

class MobileViewBuyingScreen extends StatelessWidget {
  const MobileViewBuyingScreen({
    Key? key,
    required this.homeData,
    this.dataList,
  }) : super(key: key);
  final HomeDataEntities homeData;
  final HomeCategoryDataEntities? dataList;

  @override
  Widget build(BuildContext context) {
    final themeCopy = theme;
    final size = MediaQuery.of(context).size;
    return BlocBuilder<BuyingBloc, BuyingState>(builder: (context, state) {
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
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(dataList!=null?dataList!.imageUrl!:""),
                        backgroundColor: Colors.grey,
                      ),
                      title: Text(
                        dataList!=null?dataList!.shopName!:"Shop Name",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      subtitle: const Text(
                        "100 Follows",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.normal),
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
                    
                      ProductDetails(homeData: homeData),
                    //   height10,
                    if(state is BuyingPageState)
                    reviewAndRating(review: state.review),
                    if (dataList != null) MoreProduct(dataList: dataList!,),
                  ],
                ),
              )
            ],
          ),
        ),
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
                "₹${homeData.map!["price"] ?? ""}",
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
                        ? context
                            .read<CartBloc>()
                            .add(CartDeleteData(productId: homeData.productId!))
                        : context
                            .read<CartBloc>()
                            .add(CartAddData(map: homeData.map!));
                    context
                        .read<BuyingBloc>()
                        .add(GetProductInfo(productId: homeData.productId!));
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
                        state.cartListAdded ? "Remove Cart" : "Add Cart",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: mainColor(context)),
                      ),
                    ),
                  ),
                )else Container(
                    decoration: BoxDecoration(
                        color: themeCopy.secondary,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8))),
                    width: 125,
                    height: 55,
                    child: Center(
                      child: Text(
                        "Add Cart",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: mainColor(context)),
                      ),
                    ),
                  ),
              GestureDetector(
                onTap: () {
                  if(selectedSize.isEmpty&&homeData.sizeList!.isNotEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Select a Size")));
                    return;
                  }
                  if(selectedColor.isEmpty&&homeData.colorList!.isNotEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Select a Color")));
                    return;
                  }
                  showModalBottomSheet(      
                    isDismissible: true,
                    context: context,
                    builder: (context) => OrderConform(
                      data: homeData,
                      selectedColor: selectedColor,
                      selectedSize: selectedSize,
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
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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

  Widget reviewAndRating({List<Map<String, dynamic>>? review}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextDivider(text: "Rating and Review"),
        height10,
        if (homeData.map != null && homeData.map!["rate1"] != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              width10,
              Text(
                ratingText(),
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ProgressBar(
                    homeData: homeData,
                      ratingCount: "5",
                      value: homeData.map!["rate5"].toDouble()),
                 ProgressBar(
                    homeData: homeData,
                      ratingCount: "4",
                      value: homeData.map!["rate4"].toDouble()),
                  ProgressBar(
                    homeData: homeData,
                      ratingCount: "3",
                      value: homeData.map!["rate3"].toDouble()),
                  ProgressBar(
                    homeData: homeData,
                      ratingCount: "2",
                      value: homeData.map!["rate2"].toDouble()),
                  ProgressBar(
                    homeData: homeData,
                      ratingCount: "1",
                      value: homeData.map!["rate1"].toDouble()),
                ],
              )
            ],
          ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 6),
          child: MaterialButton(
            onPressed: () {},
            color: Colors.green,
            child: const Text("Reviews"),
          ),
        ),
      ],
    );
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
