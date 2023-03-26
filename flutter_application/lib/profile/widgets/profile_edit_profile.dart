import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application/authentication/models/user.dart';
import 'package:flutter_application/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

class ProfileEditProfile extends GetView<ProfileController> {
  const ProfileEditProfile({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Edit Profile')),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // TextFormField(
                //   decoration: InputDecoration(
                //     labelText: 'Name',
                //   ),
                // ),
                // TextFormField(
                //   decoration: InputDecoration(
                //     labelText: 'Email',
                //   ),
                // ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Smart Meter No',
                  ),
                  onChanged: (value) {
                    String _smartMeterNo = value;
                    print('Smart Meter No: $_smartMeterNo');
                    controller.updateSmartMeterData(_smartMeterNo);

                  },
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Save'),
                ),
              ],
            )
          )
        ],
      )
    );
  }
}