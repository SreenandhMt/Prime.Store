
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:main_work/features/shop/presentaion/widgets/shop_order_widget.dart';
import '/core/theme/themes.dart';

import '/main.dart';

import '../bloc/notification_bloc.dart';

class ScreenNotification extends StatelessWidget {
  const ScreenNotification({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    context.read<NotificationBloc>().add(NotificationData());
    return BlocConsumer<NotificationBloc, NotificationState>(
      listener: (context, state) {
      },
      builder: (context, state) {
       if(state is NotificationDataState)
       {
        if(size.width>=1000)
        {
          return state.data.isNotEmpty? Column(
            children: List.generate(state.data.length, (index) => ShopOrderSummary(data: state.data[index]),),
          ):Center(child: Text("No data",style: mainAppTextTheme(14),),);
        }
         return Scaffold(
          appBar: AppBar(
            title: Text("Notification",style: mainAppTextTheme(20)),
            backgroundColor: theme.background,
          ),
          body: state.data.isNotEmpty? ListView.builder(
            itemBuilder: (context, index) => ShopOrderSummary(data: state.data[index]),
            itemCount: state.data.length,
          ):Center(child: Text("No data",style: mainAppTextTheme(14),),),
        );
       }else{
        if(size.width>=1000)
        {
          return const Center(child: CircularProgressIndicator(color: Colors.green,),);
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("Notification",style: mainAppTextTheme(20)),
            backgroundColor: theme.background,
          ),
          body: const Center(child: CircularProgressIndicator(color: Colors.green,),),
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
      // onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => ,)),//TODO ad order details
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
                  const SizedBox(width: 10,),
                  Text(data["status"].toString(),style: const TextStyle(color: Colors.black),),
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
