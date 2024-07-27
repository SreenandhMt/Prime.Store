import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:main_work/features/auth/presentaion/page/auth_page.dart';
import 'package:main_work/features/notification/presentaion/bloc/notification_bloc.dart';

bool click=false,updated=false;

class OrderLocation extends StatefulWidget {
  const OrderLocation({
    Key? key,
    required this.latLng,
    required this.data,
    required this.productData,
  }) : super(key: key);
  final LatLng latLng;
  final Map<String,dynamic> data;
  final Map<String,dynamic> productData;
  @override
  State<OrderLocation> createState() => _OrderLocationState();
}

class _OrderLocationState extends State<OrderLocation> {
  List<String> states = ["Order Confiremed","Shipping","Out for Delivery","Delivery"];
  String dropDownvalue="Order Confiremed";
  
  @override
  void initState() {
    click=false;
    dropDownvalue=widget.data["status"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final keyOpend= MediaQuery.of(context).viewInsets.bottom!=0;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            child: Container(
              width: double.infinity,
              height: keyOpend&&!click?(size.height/2)*0.70:click?size.height*0.9:size.height*0.55,
              color: Colors.white,
              child: GoogleMap(initialCameraPosition: CameraPosition(target: widget.latLng,zoom: 10),markers: {Marker(markerId: MarkerId("userLocation"),position: widget.latLng)},),
            ), 
          ),
          Visibility(
            visible: !click,
            child: Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      width:100,
                      height: 100,
                      decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(widget.productData["productUrls"][0].toString())),borderRadius: BorderRadius.circular(10),color: Colors.white),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        height10,
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Row(
                        children: [
                          Text("${widget.productData["productName"]}\t",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          Text("₹ ${widget.productData["price"]}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.green),)
                        ],
                      ),
                    ),
                    Text("\t${widget.productData["productAbout"]}",style: TextStyle(fontSize: 13,fontWeight: FontWeight.normal),),
                    height20,
                      ],
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
                // Padding(padding: const EdgeInsets.only(right: 15,top: 10),child: TextFormField(keyboardType: TextInputType.number,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),hintText: "Time"),),)
                DropdownButton(
                        icon: const Icon(Icons.list_sharp),
                        underline: const SizedBox(),
                        borderRadius: BorderRadius.circular(5),
                        value: dropDownvalue,
                        items: states
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            dropDownvalue = value ?? dropDownvalue;
                            updated=true;
                          });
                        }),
                        Expanded(child: SizedBox()),
                        Visibility(
                          visible: updated,
                          child: Container(
                            color: Colors.green,
                            child: Row(
                              children: [
                                SizedBox(width: 10,),
                                Text("Save and update changes in user",style: GoogleFonts.aDLaMDisplay(),),
                                Expanded(child: SizedBox()),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: MaterialButton(onPressed: (){setState(() {
                                    updated=false;
                                    context.read<NotificationBloc>().add(UpdateNotification(status: dropDownvalue, id: widget.data["productId"],data: widget.data));
                                  });},child: Text("Save"),color: Colors.yellow,),
                                ),
                              ],
                            ),
                          ),
                        )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}