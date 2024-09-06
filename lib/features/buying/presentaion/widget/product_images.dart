import 'package:flutter/material.dart';
import 'package:main_work/features/auth/presentaion/page/auth_page.dart';
import 'package:main_work/features/buying/presentaion/page/buying_page.dart';

import '../../../home/domain/entities/home_entitie.dart';

int _currentIndex=0;

class BuyingPageImages extends StatefulWidget {
  const BuyingPageImages({
    Key? key,
    required this.homeData,
  }) : super(key: key);
  final HomeDataEntities homeData;

  @override
  State<BuyingPageImages> createState() => _BuyingPageImagesState();
}

class _BuyingPageImagesState extends State<BuyingPageImages> {
  ValueNotifier currentImageUrl = ValueNotifier("");
  @override
  void initState() {
    currentImageUrl.value = widget.homeData.productUrls!.first;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if(size.width>=1000)
    {
      return ValueListenableBuilder(
            valueListenable: currentImageUrl,
            builder: (context, val, _) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                            constraints: BoxConstraints(minHeight: size.height*0.05),
                            child: Image.network(
              currentImageUrl.value,
              width: size.width*.3,
              fit: BoxFit.fitWidth,
                            ),
                          ),
            ),
            height10,
            if(widget.homeData.productUrls!.length>1)
            Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                    widget.homeData.productUrls!.length,
                    (index) => GestureDetector(
                      onTap: () {
                        _currentIndex=index;
                        currentImageUrl.value = widget.homeData.productUrls![index];
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 5),
                        height: _currentIndex==index? 60: 50,
                        width: _currentIndex==index? 60 : 55,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1.5),
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(widget.homeData.productUrls![index]))),
                      ),
                    ),
                  )),
            )
          ],
        );
      }
    );
    }
    return ValueListenableBuilder(
            valueListenable: currentImageUrl,
            builder: (context, val, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: size.width * 1),
              child: Image.network(
                currentImageUrl.value,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ),
            height10,
            if(widget.homeData.productUrls!.length>1)
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.homeData.productUrls!.length,
                  (index) => GestureDetector(
                    onTap: () {
                      _currentIndex=index;
                      currentImageUrl.value = widget.homeData.productUrls![index];
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 5),
                      height: _currentIndex==index? 60: 50,
                      width: _currentIndex==index? 60 : 55,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.5),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(widget.homeData.productUrls![index]))),
                    ),
                  ),
                ))
          ],
        );
      }
    );
  }
}
