import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application/profile/widgets/profile_change_password.dart';
import 'package:flutter_application/profile/widgets/profile_edit_profile.dart';
import 'package:flutter_application/profile/widgets/profile_notifcations.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Profile')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Name'),
              subtitle: Text('John Doe'),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: 
                ListView(
                children: [
                  Text('Preferences', style: TextStyle(fontSize: 16),),

                  ListTile(
                    onTap: (){
                      Get.to(ProfileEditProfile());
                    },
                    leading: Icon(Icons.edit),
                    title: Text('Edit Profile'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),

                  ListTile(
                    leading: Icon(Icons.lock),
                    title: Text('Change Password'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: (){
                      Get.to(ProfileChangePassword());
                    },),

                  ListTile(
                    trailing: Icon(Icons.arrow_forward_ios),
                    leading: Icon(Icons.notifications),
                    title: Text('Notifications'),
                    onTap: (){
                      Get.to(ProfileNotification());
                    },)
                ],
              ),
            ),
          CupertinoButton(
            onPressed: () {},
            color: Colors.red,
            child: Text('Log Out'),),
          Spacer(),
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Lottie.asset('assets/animations/energy.json', 
                frameRate: FrameRate.max,
                repeat: true,
                animate: true,
                fit: BoxFit.contain,)),
          ],

        ),
      ),
    );
  }
}