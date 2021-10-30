import 'package:ecomrs_user_pannel/auth/firebase_auth.dart';
import 'package:ecomrs_user_pannel/pages/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 200,
            color: Colors.indigo,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("My Profiel"),
          ),
          ListTile(
            leading: Icon(Icons.reorder),
            title: Text("Orders"),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            onTap: (){
              FirebaseAuthServices.logoutUser().then((value) => Navigator.pushReplacementNamed(context, LoginPage.routeName));
            },
            title: Text("Logout"),
          ),

        ],
      ),
    );
  }
}
