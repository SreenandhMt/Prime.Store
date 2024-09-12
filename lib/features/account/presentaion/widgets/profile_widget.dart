import 'package:flutter/material.dart';

import 'package:main_work/features/account/presentaion/widgets/edit_profile.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({
    Key? key,
    required this.profile,
  }) : super(key: key);
  final Map<String,dynamic> profile;

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'My Profile',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'You can edit/update your profile information by click on edit profile button.',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 30),
                          Wrap(
                            runSpacing: 30,
                            spacing: 40,
                            children: [
                              _buildProfileInfoRow('FULL NAME', widget.profile["name"]??""),
                          _buildProfileInfoRow('EMAIL', widget.profile["email"]??""),
                          _buildProfileInfoRow('PHONE NUMBER', '+91 ${widget.profile["number"]??""}'),
                          _buildProfileInfoRow('DATE OF BIRTH', widget.profile["birthday"]??""),
                          _buildProfileInfoRow('GENDER', widget.profile["gender"]??""),
                            ],
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(context: context, builder: (context) => Dialog(shape: Border.all(),child: const EditProfilePage(),),);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            ),
                            child: const Text('EDIT PROFILE'),
                          ),
                        ],
                      );
  }

  Widget _buildProfileInfoRow(String label, String value) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width>=1000?size.width*0.14:size.width*0.4,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
