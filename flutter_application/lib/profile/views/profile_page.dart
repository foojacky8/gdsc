import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application/profile/controllers/profile_controller.dart';
import 'package:flutter_application/profile/widgets/profile_change_password.dart';
import 'package:flutter_application/profile/widgets/profile_edit_profile.dart';
import 'package:flutter_application/profile/widgets/profile_notifcations.dart';
import 'package:flutter_application/profile/widgets/recent_order.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../repository/authentication_repository/authentication_repository.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  String? name = AuthenticationRepository.instance.firebaseUser.value!.email;

  @override
  Widget build(BuildContext context) {
    final ProfileController _profileController = Get.put(ProfileController());

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
              title: Text('$name'),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: 
                ListView(
                children: [
                  Text('Preferences', style: TextStyle(fontSize: 16),),
                  ListTile(
                    leading: Icon(Icons.insert_chart_outlined_sharp),
                    title: Text('Recent Orders'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: (){
                      Get.to(RecentOrder());
                    },),
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

                  // ListTile(
                  //   trailing: Icon(Icons.arrow_forward_ios),
                  //   leading: Icon(Icons.notifications),
                  //   title: Text('Notifications'),
                  //   onTap: (){
                  //     Get.to(ProfileNotification());
                  //   },)
                ],
              ),
            ),
          CupertinoButton(
            onPressed: () {
              AuthenticationRepository.instance.signOut();
            },
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