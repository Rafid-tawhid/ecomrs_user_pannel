import 'dart:core';

import 'package:flutter/material.dart';
class CartModel{
  String productId;
  String productName;
  num price;
  int qty;

  CartModel({
    required this.productId,required this.productName,required this.price,this.qty=1
});
}