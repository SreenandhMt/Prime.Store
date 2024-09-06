import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_work/core/theme/themes.dart';

import '../../../../main.dart';
import '../../../home/domain/entities/home_entitie.dart';
import '../page/buying_page.dart';

int _currentColor = -1, _currentSize = -1,_currentColorColum = 0,_currentSizeColum = 0;
String selectedColor="",selectedSize="";

class ProductDetails extends StatefulWidget {
  const ProductDetails({
    Key? key,
    required this.homeData,
  }) : super(key: key);
  final HomeDataEntities homeData;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  List<String>? children,men,women,normal;
  @override
  void initState() {
    for (var size in widget.homeData.sizeList!) {
      if(size.toString().startsWith("C")&&size.toString().split("C").length!=1&&(int.tryParse(size.toString().split("C").last)!=null))
      {
        children??=[];
        children!.add(size);
      }else if(size.toString().startsWith("M")&&size.toString().split("M").length!=1&&(int.tryParse(size.toString().split("M").last)!=null))
      {
        men??=[];
        men!.add(size);
      }else if(size.toString().startsWith("W")&&size.toString().split("W").length!=1&&(int.tryParse(size.toString().split("W").last)!=null))
      {
        women??=[];
        women!.add(size);
      }else
      {
        normal??=[];
        normal!.add(size);
      }
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (widget.homeData.colorList == null&&widget.homeData.sizeList == null||widget.homeData.colorList!.isEmpty&&widget.homeData.sizeList!.isEmpty) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
                      height: 20,
                    ),
        divider,
        const SizedBox(
          height: 10,
        ),
        if (widget.homeData.colorList != null &&
            widget.homeData.colorList!.isNotEmpty)
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
              Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: List.generate(
                      widget.homeData.colorList!.length,
                      (index) => GestureDetector(
                            onTap: () {
                              _currentColor = index;
                              selectedColor = widget.homeData.colorList![index];
                              setState(() {});
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 7),
                              padding: const EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                border: _currentColor == index
                                      ? Border.all(
                                          width: 3, color: Colors.lightGreen)
                                      : Border.all(),
                                  color: theme.tertiary,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                  widget.homeData.colorList![index],style: mainAppTextTheme(null),),
                            ),
                          ))),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          if(women!=null&&women!.isNotEmpty)
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 11, bottom: 10, top: 10),
                child: Text(
                  "Women Size",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              Wrap(
                  runSpacing: 10,
                  children: List.generate(
                      women!.length,
                      (index) => GestureDetector(
                            onTap: () {
                              _currentSize = index;
                              _currentSizeColum = 0;
                              selectedSize = women![index];
                              setState(() {});
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 7),
                              padding: const EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                  border: _currentSize == index&&_currentSizeColum==0
                                      ? Border.all(
                                          width: 3, color: Colors.lightGreen)
                                      : Border.all(),
                                  color: theme.tertiary,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                  women![index],style: mainAppTextTheme(null),),
                            ),
                          ))),
            ],
          ),
        if(men!=null&&men!.isNotEmpty)
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 11, bottom: 10, top: 10),
                child: Text(
                  "Men Size",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              Wrap(
                  runSpacing: 10,
                  children: List.generate(
                      men!.length,
                      (index) => GestureDetector(
                            onTap: () {
                              _currentSize = index;
                              _currentSizeColum = 1;
                              selectedSize = men![index];
                              setState(() {});
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 7),
                              padding: const EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                  border: _currentSize == index&&_currentSizeColum==1
                                      ? Border.all(
                                          width: 3, color: Colors.lightGreen)
                                      : Border.all(),
                                  color: theme.tertiary,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                  men![index],style: mainAppTextTheme(null),),
                            ),
                          ))),
            ],
          ),
          
           if(children!=null&&children!.isNotEmpty)
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 11, bottom: 10, top: 10),
                child: Text(
                  "Childern Size",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              Wrap(
                  runSpacing: 10,
                  children: List.generate(
                      children!.length,
                      (index) => GestureDetector(
                            onTap: () {
                              _currentSize = index;
                              _currentSizeColum = 2;
                              selectedSize = children![index];
                              setState(() {});
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 7),
                              padding: const EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                  border: _currentSize == index&&_currentSizeColum==2
                                      ? Border.all(
                                          width: 3, color: Colors.lightGreen)
                                      : Border.all(),
                                  color: theme.tertiary,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                  children![index],style: mainAppTextTheme(null),),
                            ),
                          ))),
            ],
          ),
        if (normal != null &&
            normal!.isNotEmpty)
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
                      normal!.length,
                      (index) => GestureDetector(
                            onTap: () {
                              _currentSize = index;
                              _currentSizeColum = 3;
                              selectedSize = normal![index];
                              setState(() {});
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 7),
                              padding: const EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                  border: _currentSize == index&&_currentSizeColum==3
                                      ? Border.all(
                                          width: 3, color: Colors.lightGreen)
                                      : Border.all(),
                                  color: theme.tertiary,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                  normal![index],style: mainAppTextTheme(null),),
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
