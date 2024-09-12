
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_work/features/account/presentaion/bloc/bloc/account_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController fullname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController birthday = TextEditingController();

  String selectedGenter = "non";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width>=1000? size.width*0.3 : size.width*0.9,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('General Information'),
            const SizedBox(height: 20,),
            const Text("FULL NAME",style: TextStyle(color: Colors.grey)),
            TextField(
              controller: fullname,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                hintText: 'name',
              ),
            ),
            const SizedBox(height: 15),
            const Text("LAST NAME",style: TextStyle(color: Colors.grey)),
            TextField(
              controller: lastname,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                hintText: 'last name',
              ),
            ),
            const SizedBox(height: 15),
            const Text("EMAIL ADDRESS",style: TextStyle(color: Colors.grey)),
            TextField(
              controller: email,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                hintText: 'exaple@gmail.com',
                // enabled: false, // Disables the email field (assuming it's non-editable)
              ),
            ),
            const SizedBox(height: 15),
            const Text("PHONE NUMBER",style: TextStyle(color: Colors.grey)),
            TextField(
              controller: phoneNumber,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                // labelText: '',
                hintText: '0000000000',
                prefixText: '+91 ',
              ),
            ),
            const SizedBox(height: 15),
            const Text("DATE OF BIRTH (DD-MM-YYYY)",style: TextStyle(color: Colors.grey)),
            TextField(
              controller: birthday,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                hintText: 'dd-mm-yyyy',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'GENDER',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: const Text('Male'),
                    value: 'male',
                    groupValue: selectedGenter, 
                    contentPadding: const EdgeInsets.all(0),
                    selected: selectedGenter == 'male',
                    onChanged: (value) {
                      setState(() {
                        if(selectedGenter == value)
                        {
                          selectedGenter = "non";
                        }
                        if(value==null)return;
                        selectedGenter = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: const Text('Female'),
                    value: 'female',
                    contentPadding: const EdgeInsets.all(0),
                    groupValue: selectedGenter,
                    onChanged: (value) {
                      setState(() {
                        if(selectedGenter == value)
                        {
                          selectedGenter = "non";
                        }
                        if(value==null)return;
                        selectedGenter = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: const Text('Not Specified'),
                    value: 'not_specified',
                    groupValue: selectedGenter,
                    contentPadding: const EdgeInsets.all(0),
                    onChanged: (value) {
                      setState(() {
                        if(selectedGenter == value)
                        {
                          selectedGenter = "non";
                        }
                        if(value==null)return;
                        selectedGenter = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
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
                    context.read<AccountBloc>().add(EditProfile(name: '${fullname.text} ${lastname.text}', phoneNumber: phoneNumber.text, email: email.text, birthday: birthday.text, gender: selectedGenter));
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
    );
  }
}
