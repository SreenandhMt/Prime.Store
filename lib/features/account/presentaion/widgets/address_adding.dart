import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:main_work/core/main_data/module/address_module.dart';
import 'package:main_work/features/buying/presentaion/blocs/bloc/confrom_bloc.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;

class AddressAddingPage extends StatefulWidget {
  const AddressAddingPage({
    Key? key,
    this.data,
    this.isBuyingPage,
  }) : super(key: key);
  final AddressData? data;
  final bool? isBuyingPage;
  @override
  _AddressAddingPageState createState() => _AddressAddingPageState();
}

class _AddressAddingPageState extends State<AddressAddingPage> {
  late TextEditingController nameController ;
  late TextEditingController lastController ;
  late TextEditingController numberController ;
  late TextEditingController postcodeController ;
  late TextEditingController stateController ;
  late TextEditingController cityController ;
  late TextEditingController address1Controller ;
  late TextEditingController address2Controller ;
  late TextEditingController landmarkController ;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if(widget.data!=null)
    {
      nameController = TextEditingController(text: widget.data!.name!.split(" ").first);
    lastController = TextEditingController(text: widget.data!.name!.split(" ").last);
    numberController = TextEditingController(text:  widget.data!.number);
    postcodeController = TextEditingController(text:  widget.data!.postcode);
    stateController = TextEditingController(text:  widget.data!.state);
    cityController = TextEditingController(text:  widget.data!.city);
    address1Controller = TextEditingController(text:  widget.data!.address1);
    address2Controller = TextEditingController(text:  widget.data!.address2);
    landmarkController = TextEditingController(text:  widget.data!.landmark);
    }
    else{
      nameController = TextEditingController();
    lastController = TextEditingController();
    numberController = TextEditingController();
    postcodeController = TextEditingController();
    stateController = TextEditingController();
    cityController = TextEditingController();
    address1Controller = TextEditingController();
    address2Controller = TextEditingController();
    landmarkController = TextEditingController();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width>=1000? size.width*0.4:size.width*0.8,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              textFieldCustom(label: "Enter name here",title: "FIRST NAME",controller: nameController),
              const SizedBox(height: 10,),
              textFieldCustom(label: "Enter name here",title: "LAST NAME",controller: lastController),
              const SizedBox(height: 10,),
              
              Row(
                children: [
                  LimitedBox(maxWidth: ((size.width>=1000? size.width*0.4:size.width*0.8)/2)*0.84,maxHeight: 90,child: textField(title: 'Mobile Number', label: 'Enter Mobile Numer here',controller: numberController)),
                  const SizedBox(width: 5,),
                   LimitedBox(maxWidth: ((size.width>=1000? size.width*0.4:size.width*0.8)/2)*0.8,maxHeight: 90,child:textField(title: "POST CODE", label: 'Enter postcode here',controller: postcodeController)) 
                ],
              ),
              Row(
                children: [
                  LimitedBox(maxWidth: ((size.width>=1000? size.width*0.4:size.width*0.8)/2)*0.84,maxHeight: 90,child: textField(title: "State", label: 'Delivery State',controller: stateController)),
                  const SizedBox(width: 5,),
                   LimitedBox(maxWidth: ((size.width>=1000? size.width*0.4:size.width*0.8)/2)*0.8,maxHeight: 90,child:textField(title: "CITY/TOWN", label: 'Delivery city/town',controller: cityController)) 
                ],
              ),
              textFieldCustom(label: "Enter delivery address here",title: "Address 1(FLAT, HOUSE NO, BUILDING, COMPANY, APARTMENT)",controller: address1Controller),
              const SizedBox(height: 10,),
              textFieldCustom(label: "Enter delivery area, colony, street, sector, village",title: "Address 2(AREA, COLONY, STREET, SECTOR, VILLAGE)",controller: address2Controller),
              const SizedBox(height: 10,),
              textFieldCustom(label: "Eg. Behind the park",title: "LANDMARK",controller: landmarkController),
             const SizedBox(height: 20,),
              Row(
                children: <Widget>[
                  Radio(value: 1, groupValue: 1, onChanged: (int? value) {}),
                  const Text('Home'),
                  Radio(value: 2, groupValue: 1, onChanged: (int? value) {}),
                  const Text('Office/Commercial'),
                ],
              ),
              const SizedBox(height: 10,),
               Row(
                children: <Widget>[
                  Checkbox(value: false, onChanged: (bool? value) {}),
                  const Text('Make this my default address'),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: const EdgeInsets.only(left: 50,top: 20,right: 50,bottom: 20),
                  color: Colors.white,
                  child: const Text('CANCEL',style: TextStyle(color: Colors.red),),
                  ),
                  const SizedBox(width: 8,),
                MaterialButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate())
                    {
                      if(widget.data!=null)
                      {
                        updateAddress();
                        return;
                      }
                      addAddress();
                    }
                  },
                  padding: const EdgeInsets.only(left: 50,top: 20,right: 50,bottom: 20),
                  color: Colors.red,
                  child: const Text('SAVE'),
                ),
              ],
            ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField({required String label,required String title,required TextEditingController controller})
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: const TextStyle(color: Colors.grey),),
        const SizedBox(height: 6,),
       TextFormField(controller: controller,decoration: InputDecoration(hintText: label,border: OutlineInputBorder(borderRadius: BorderRadius.circular(6))),validator: (value) {
         if(value==null)
          {
            return "Fill form";
          }
          if(value.isEmpty)
          {
            return "Fill form";
          }
       },),
      ],
    );
  }

  Widget textFieldCustom({required String label,required String title,required TextEditingController controller})
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10,),
        Text(title,style: const TextStyle(color: Colors.grey),),
        const SizedBox(height: 6,),
        TextFormField(controller: controller,decoration: InputDecoration(hintText: label,border: OutlineInputBorder(borderRadius: BorderRadius.circular(6))),validator: (value) {
          if(value==null)
          {
            return "Fill form";
          }
          if(value.isEmpty)
          {
            return "Fill form";
          }
        },)
      ],
    );
  }

  Widget removeConformDialog(){
    return Container(
      child: Column(
        children: [
          Text("Do you what to delete this address"),
          MaterialButton(onPressed: () {
            _firestore.collection("address").doc(widget.data!.id).delete();
          },child: Center(child: Text("Conform"),),),
          MaterialButton(onPressed: () {
            Navigator.pop(context);
          },child: Center(child: Text("Cancel"),),)
        ],
      ),
    );
  }

  Future<void> updateAddress()async
  {
    try {
      final id = widget.data!.id;
      _firestore.collection("address").doc(id).set({
        "id":id,
        "uid":_auth.currentUser!.uid,
        "name":"${nameController.text} ${lastController.text}",
        "number":numberController.text,
        "postcode":postcodeController.text,
        "state":stateController.text,
        "city":cityController.text,
        "address1":address1Controller.text,
        "address2":address2Controller.text,
        "landmark":landmarkController.text,
        "default":true,
      });
      Navigator.pop(context);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> addAddress()async
  {
    try {
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      _firestore.collection("address").doc(id).set({
        "id":id,
        "uid":_auth.currentUser!.uid,
        "name":"${nameController.text} ${lastController.text}",
        "number":numberController.text,
        "postcode":postcodeController.text,
        "state":stateController.text,
        "city":cityController.text,
        "address1":address1Controller.text,
        "address2":address2Controller.text,
        "landmark":landmarkController.text,
        "default":true,
      });
      Navigator.pop(context);
      if(widget.isBuyingPage!=null&&widget.isBuyingPage!)
      {
        context.read<ConfromBloc>().add(CheckRequest());
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
