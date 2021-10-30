


import 'dart:io';
import 'dart:ui';

import 'package:ecomrs_user_pannel/provider/product_provider.dart';
import 'package:ecomrs_user_pannel/utilities/constant.dart';
import 'package:ecomrs_user_pannel/widgets/drawer_main.dart';
import 'package:ecomrs_user_pannel/widgets/list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ProductListPage extends StatefulWidget {
  static const String routeName='/products';
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late ProductProvider _productProvider;

  @override
  void didChangeDependencies() {
    _productProvider = Provider.of<ProductProvider>(context, listen: false);
    _productProvider.getAllProducts();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Our Products",),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart))
        ],
      ),
      drawer: MainDrawer(),
      body: _productProvider.productList.isEmpty ?Center(child: Text("No Product Found"),) :

      GridView.count(
        padding: EdgeInsets.all(8),
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        childAspectRatio: .5,
        children: _productProvider.productList.map((e) => ProductItems(e)).toList(),


      )
    );


  }

  Widget fadedImageWidget(String url){
    return FadeInImage.assetNetwork(placeholder: 'images/ph1.png', image: url,
    fadeInDuration: Duration(seconds: 3),
    fadeInCurve: Curves.bounceIn,fit: BoxFit.cover,);
  }



}
