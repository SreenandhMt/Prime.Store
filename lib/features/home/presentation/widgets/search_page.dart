// import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/features/auth/presentaion/page/auth_page.dart';
import '/features/home/data/module/home_module.dart';
import '/features/home/presentation/pages/home_page.dart';
import '/features/home/presentation/widgets/home_widgets.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
ValueNotifier<List<HomeData>> result = ValueNotifier<List<HomeData>>([]);
List<HomeData> searchQuary=[];
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(title: CupertinoSearchTextField(onChanged: (value) => getAllData(search: value),padding: EdgeInsets.all(10),),),
        body: ValueListenableBuilder(
          valueListenable: result,
          builder: (context,va,_) {
            return Column(
              children: [
                height10,
                Row(children: [
                  IconButton(onPressed: ()=>Navigator.pop(context), icon: const Icon(Icons.navigate_before_rounded,size: 36,)),
                  width10,
                  LimitedBox(maxWidth: size.width*0.8,child: CupertinoSearchTextField(onChanged: (value) => getAllData(search: value),padding: const EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),)),
                ],),
                height10,
                Expanded(
                  child: SingleChildScrollView(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Wrap(
                        children: List.generate(result.value.length, (index) => ProductWidget(data: result.value[index])),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
  Future<List<HomeData>> getAllData({required String search})async{
    result.value.clear();
    if(searchQuary.isEmpty)
    {
       searchQuary = await _firestore.collection("products").get().then((value) => value.docs.map((e) => HomeData.formjson(e.data())).toList());
    }
    // log(searchQuary.toString());
    for (var results in searchQuary) {
      if(results.productName!.toUpperCase().contains(search.toUpperCase())||results.productAbout!.toLowerCase().contains(search.toLowerCase()))
      {
        result.value.add(results);
        result.notifyListeners();
      }
    }
    return result.value;
  }
}