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

class DesktopViewBuyingScreen extends StatefulWidget {
  const DesktopViewBuyingScreen({
    Key? key,
    this.id,
  }) : super(key: key);
  final String? id;

  @override
  State<DesktopViewBuyingScreen> createState() => _DesktopViewBuyingScreenState();
}

class _DesktopViewBuyingScreenState extends State<DesktopViewBuyingScreen> {
  HomeDataEntities? homeData;
  HomeCategoryDataEntities? dataList;
  bool favoritStatus=false,cartStatus=false;
  @override
  void initState() {
    context
        .read<BuyingBloc>()
        .add(GetProductInfo(noData: widget.id!=null,productId: homeData==null?widget.id!:homeData!.productId!));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final themeCopy = theme;
    final size = MediaQuery.of(context).size;
    return BlocBuilder<BuyingBloc, BuyingState>(builder: (context, state) {
      if(homeData==null)
      {
        if (state is BuyingPageState) {
          homeData = state.data;
          dataList = state.moreProduct;
          cartStatus = state.cartListAdded;
          favoritStatus = state.favoritListAdded;
          context
        .read<BuyingBloc>()
        .add(GetProductInfo(noData: widget.id!=null,productId: homeData==null?widget.id!:homeData!.productId!));
        }
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      if(state is BuyingPageState)
      {
        return Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              BuyingPageAppBar(homeData: homeData!,favoritStatus: favoritStatus,),
              height10,
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Expanded(child: SizedBox()),
                  SizedBox(width: size.width*.3,height: size.height*0.8,child: BuyingPageImages(homeData: homeData!)),
                  const SizedBox(width: 30),
                  Container(
                    width: size.width*.4,
                  decoration: BoxDecoration(
                      color: theme.background,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      BuyingTexts(homeData: homeData!),
                      Row(
                        children: [
                GestureDetector(
                  onTap: () async {
                    cartStatus = !cartStatus;
                    setState(() {
                      
                    });
                    cartStatus
                        ? context
                            .read<CartBloc>()
                            .add(CartDeleteData(productId: homeData!.productId!))
                        : context
                            .read<CartBloc>()
                            .add(CartAddData(map: homeData!.map!));
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
                ),
              GestureDetector(
                onTap: () {
                  if(selectedSize.isEmpty&&homeData!.sizeList!.isNotEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(behavior: SnackBarBehavior.floating,margin: const EdgeInsets.all(10),content: Container(child: const Text("Select a Color"),)));
                    return;
                  }
                  if(selectedColor.isEmpty&&homeData!.colorList!.isNotEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Select a Size")));
                    return;
                  }
                  showModalBottomSheet(
                    isDismissible: true,
                    context: context,
                    builder: (context) => OrderConform(
                      data: homeData!,
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
                        ProductDetails(homeData: homeData!),
                        const TextDivider(text: "Shop Address"),
                      height10,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${state.shopAddress!.address1},\n'
                          '${state.shopAddress!.address2},\n'
                          '${state.shopAddress!.landmark}, ${state.shopAddress!.landmark} ${state.shopAddress!.state} - ${state.shopAddress!.postcode}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      // Mobile number
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Mobile: +91 ${state.shopAddress!.number}',
                          style: const TextStyle(
                              fontSize: 16),
                        ),
                      ),
                      height10,
                      //   height10,
                      if(state is BuyingPageState)
                      reviewAndRating(review: state.review),
                    if (dataList != null) MoreProduct(dataList: dataList!),
                    ],
                  ),
                                  ),
                                  const Expanded(child: SizedBox()),
                ],),
              )
            ],
          ),
        ),
      );
      }else{
        return const SizedBox();
      }
    });
  }

  Widget reviewAndRating({List<Map<String, dynamic>>? review}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextDivider(text: "Rating and Review"),
        height10,
        if (homeData!.map != null && homeData!.map!["rate1"] != null)
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
                    homeData: homeData!,
                      ratingCount: "5",
                      value: homeData!.map!["rate5"].toDouble()),
                 ProgressBar(
                    homeData: homeData!,
                      ratingCount: "4",
                      value: homeData!.map!["rate4"].toDouble()),
                  ProgressBar(
                    homeData: homeData!,
                      ratingCount: "3",
                      value: homeData!.map!["rate3"].toDouble()),
                  ProgressBar(
                    homeData: homeData!,
                      ratingCount: "2",
                      value: homeData!.map!["rate2"].toDouble()),
                  ProgressBar(
                    homeData: homeData!,
                      ratingCount: "1",
                      value: homeData!.map!["rate1"].toDouble()),
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
        top = homeData!.map!["rate$i"];
        rateindex = i;
      } else if (homeData!.map!["rate$i"] > top) {
        top = homeData!.map!["rate$i"];
        rateindex = i;
      }
    }
    return top != null ? "$rateindex" : "";
  }
}
