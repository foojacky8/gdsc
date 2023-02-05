import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileChangePassword extends StatelessWidget {
  const ProfileChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Change Password')),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Text(
              'Create a new Password',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Current Password',
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'New Password',
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
              ),
            ),

            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {},
              child: Text('Change Password'),
            ),
          ],
        )
      )
    );
  }
}