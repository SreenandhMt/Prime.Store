import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:main_work/core/theme/themes.dart';

import 'package:main_work/features/notification/presentaion/page/location.dart';
import 'package:main_work/main.dart';

import '../bloc/notification_bloc.dart';

class ScreenNotification extends StatelessWidget {
  const ScreenNotification({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NotificationBloc>().add(NotificationData());
    return BlocConsumer<NotificationBloc, NotificationState>(
      listener: (context, state) {
      },
      builder: (context, state) {
       if(state is NotificationDataState)
       {
        log(state.data.toString());
         return Scaffold(
          appBar: AppBar(
            title: Text("Notification",style: mainAppTextTheme(20)),
            backgroundColor: theme.background,
          ),
          body: state.data.isNotEmpty? ListView.builder(
            itemBuilder: (context, index) => NotificationWidget(data: state.data[index],latLng: LatLng(state.location[index]!["locX"], state.location[index]!["locY"]),prodectData: state.productData[index]!,),
            itemCount: state.data.length,
          ):Center(child: Text("No data",style: mainAppTextTheme(14),),),
        );
       }else{
        return Scaffold(
          appBar: AppBar(
            title: Text("Notification",style: mainAppTextTheme(20)),
            backgroundColor: theme.background,
          ),
          body: Center(child: CircularProgressIndicator(color: Colors.green,),),
        );
       }
      },
    );
  }
}

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    Key? key,
    required this.latLng,
    required this.data,
    required this.prodectData,
  }) : super(key: key);
  final LatLng latLng;
  final Map<String,dynamic> data;
  final Map<String,dynamic> prodectData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderLocation(latLng: latLng,data: data,productData: prodectData,),)),
      child: Container(
        margin: const EdgeInsets.only(top: 4, left: 10, right: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey.shade800, borderRadius: BorderRadius.circular(2)),
        child: Row(
          children:[
             Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Order",
                style: GoogleFonts.aDLaMDisplay(fontSize: 18,color: Colors.green)),
              Container(width: 50,height: 50,decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(prodectData["productUrls"][0].toString()))),),
              Row(
                children: [
                  Text(prodectData["productName"].toString(),style: GoogleFonts.aBeeZee(),),
                  SizedBox(width: 10,),
                  Text(data["status"].toString(),style: TextStyle(color: Colors.black),),
                ],
              ),
              const Text("Location 1/km")
            ],
          ),
          const Expanded(child: SizedBox()),
          const Icon(Icons.location_on_rounded),
          ]
        ),
      ),
    );
  }
}
