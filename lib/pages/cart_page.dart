import 'package:ecomrs_user_pannel/pages/customer_info_page.dart';
import 'package:ecomrs_user_pannel/provider/cart_provider.dart';
import 'package:ecomrs_user_pannel/utilities/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  static const String routeName='/cart_page';
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
        actions: [
          Consumer<CartProvider>(
            builder:(context,provider,_)=>
              IconButton(onPressed: (){
                provider.removeAll();

              }, icon: Icon(Icons.cancel)))
        ],
      ),
      body: Consumer<CartProvider>(
        builder:(context,provider,_) => Column(
          children: [
            Expanded(child:provider.totalsItemsInCart==0?Center(child: Text('Cart is Empty'),):
            ListView.builder(itemCount: provider.cartList.length,
                itemBuilder: (context,index){
              final cartModel=provider.cartList[index];
              return ListTile(

                title: Text(cartModel.productName,style: TextStyle(fontSize: 18),),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Quantity : ${cartModel.qty}'), //${provider.qty}
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: (){
                          provider.decreaseQty(cartModel);
                        }, icon: Icon(Icons.remove)),
                        Text('Qty'),
                        IconButton(onPressed: (){
                          provider.increseQty(cartModel);
                        }, icon: Icon(Icons.add)),
                      ],
                    ),


                  ],

                ),
                trailing: Text('$taka${provider.getPriceWithQty(cartModel)}'),

              );
                }),

            ),
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.red
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Price : ${provider.cartItemsTotalPrice}',style: TextStyle(color: Colors.white,fontSize: 18),),//
                  if(provider.totalsItemsInCart>0)TextButton(onPressed:(){
                    Navigator.pushNamed(context, CustomerInfoPage.routeName);
                    
                  }, child: Text('CheckOut'),
                    style: TextButton.styleFrom(
                        primary: Colors.white
                    ),)

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
