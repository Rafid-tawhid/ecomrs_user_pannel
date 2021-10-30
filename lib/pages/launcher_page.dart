import 'dart:async';
import 'package:ecomrs_user_pannel/auth/firebase_auth.dart';
import 'package:ecomrs_user_pannel/pages/product_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loginPage.dart';

class LauncherPage extends StatefulWidget {
  static const String routeName='/';

  @override
  _LauncherPageState createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {

  @override
  void initState() {

  Future.delayed(Duration.zero,(){
    if(FirebaseAuthServices.currentUser == null)
    {
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
    }
    else
    {
      Navigator.pushReplacementNamed(context, ProductListPage.routeName);
    }
  });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

