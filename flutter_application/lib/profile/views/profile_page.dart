import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView(
                children: [
                  Text('Preferences', style: TextStyle(fontSize: 16),),

                  ListTile(
                    onTap: (){
                      Navigator.pushNamed(context, '/edit_profile');
                    },
                    leading: Icon(Icons.person),
                    title: Text('Edit Profile'),
                  ),

                  ListTile(
                    leading: Icon(Icons.lock),
                    title: Text('Change Password'),),

                  ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text('Notifications'),)
                ],
              ),
            ),
          Positioned(
            bottom: 0,
            child: CupertinoButton(
              onPressed: () {},
              color: Colors.red,
              child: Text('Log Out'),),
          )
          ],

        ),
      ),
    );
  }
}