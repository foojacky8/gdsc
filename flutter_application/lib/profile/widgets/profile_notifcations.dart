import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileNotification extends StatefulWidget {
  const ProfileNotification({super.key});

  @override
  State<ProfileNotification> createState() => _ProfileNotificationState();
}

class _ProfileNotificationState extends State<ProfileNotification> {

  bool emailNotifications = true;
  bool pushNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Notifications Settings')),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Text('Email Notifications'),
                    Spacer(),
                    Switch(
                      value: emailNotifications,
                      onChanged: (value) {
                        setState(() {
                          emailNotifications = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Text('Push Notifications'),
                    Spacer(),
                    Switch(
                      value: pushNotifications,
                      onChanged: (value) {
                        setState(() {
                          pushNotifications = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            )
          )
      ],)
    );
  }
}