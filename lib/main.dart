import 'package:ecomrs_user_pannel/pages/cart_page.dart';
import 'package:ecomrs_user_pannel/pages/launcher_page.dart';
import 'package:ecomrs_user_pannel/pages/loginPage.dart';
import 'package:ecomrs_user_pannel/pages/product_list_page.dart';
import 'package:ecomrs_user_pannel/provider/cart_provider.dart';
import 'package:ecomrs_user_pannel/provider/customer_provider.dart';
import 'package:ecomrs_user_pannel/provider/order_provider.dart';
import 'package:ecomrs_user_pannel/provider/product_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>ProductProvider()),
        ChangeNotifierProvider(create: (context)=>CartProvider()),
        ChangeNotifierProvider(create: (context)=>OrderProvider()),
        ChangeNotifierProvider(create: (context)=>CustomerProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        // home: LoginPage(),
        initialRoute: LauncherPage.routeName,
        routes: {
          LauncherPage.routeName: (context) =>LauncherPage(),
          LoginPage.routeName: (context) =>LoginPage(),
          ProductListPage.routeName: (context) =>ProductListPage(),
          CartPage.routeName: (context) =>CartPage()
        },
      ),
    );
  }
}
