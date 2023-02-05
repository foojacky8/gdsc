import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileEditProfile extends StatelessWidget {
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
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Smart Meter No',
                  ),
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