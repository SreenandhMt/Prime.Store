import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main_work/core/main_data/module/address_module.dart';
import 'package:main_work/features/account/presentaion/widgets/address_adding.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;

class AddressCard extends StatefulWidget {
  const AddressCard({super.key});

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: getAddress(), builder:(context, snapshot) {
      if(snapshot.data==null)
      {
        return Center(child: CircularProgressIndicator());
      }
      return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: List.generate(snapshot.data!.length, (index) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name and tag
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${snapshot.data![index].name}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(context: context, builder: (context) => Dialog(child: AddressAddingPage(data: snapshot.data![index],),shape: Border.all(),),);
                        },
                        child: Text(
                          'EDIT',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          showDialog(context: context, builder: (context) => Dialog(child: removeConformDialog(context, snapshot.data![index].id),shape: Border.all(),),);
                        },
                        child: const Text(
                          'REMOVE',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Address details
              Text(
                '${snapshot.data![index].address1},\n'
                '${snapshot.data![index].address2},\n'
                '${snapshot.data![index].landmark}, ${snapshot.data![index].landmark} ${snapshot.data![index].state} - ${snapshot.data![index].postcode}',
                style: TextStyle( fontSize: 16),
              ),
              const SizedBox(height: 10),
              // Mobile number
              Text(
                'Mobile: +91 ${snapshot.data![index].number}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),),
      )
    );
    },);
  }

  Future<List<AddressData>> getAddress()async{
    return _firestore.collection("address").where("uid", isEqualTo: _auth.currentUser!.uid).get().then((value) => value.docs.map((e) => AddressData.formjson(e.data()),).toList(),);
  }

  Widget removeConformDialog(context,id){
    return Container(
      width: 300,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Do you what to delete this address",style: TextStyle(fontSize: 15),),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                color: Colors.red,
                padding: EdgeInsets.all(20),
                onPressed: () {
            _firestore.collection("address").doc(id).delete();
            setState(() {
              
            });
          },child: Center(child: Text("Conform"),),),
          SizedBox(width: 7,),
          MaterialButton(
            padding: EdgeInsets.all(20),
            onPressed: () {
            Navigator.pop(context);
          },child: Center(child: Text("Cancel",style: TextStyle(color: Colors.red),),),)
            ],
          )
        ],
      ),
    );
  }
}