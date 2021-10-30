import 'package:ecomrs_user_pannel/models/product_model.dart';
import 'package:ecomrs_user_pannel/provider/cart_provider.dart';
import 'package:ecomrs_user_pannel/utilities/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItems extends StatefulWidget {
  ProductModel _productModel;


  ProductItems(this._productModel);

  @override
  _ProductItemsState createState() => _ProductItemsState();
}

class _ProductItemsState extends State<ProductItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 7,
        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(15)
        ),
        child: Column(
          children: [
            Expanded(
          child: ClipRRect(
            borderRadius:BorderRadius.circular(15),
            child: FadeInImage.assetNetwork(placeholder: 'images/ph1.png', image: widget._productModel.downloadImageUrl!,
              fadeInDuration: Duration(seconds: 3),
              fadeInCurve: Curves.bounceIn,fit: BoxFit.cover,width: double.maxFinite,height: 200,),
          ),
        ),
            ListTile(
              title: Text(widget._productModel.name!),
              subtitle: Text(widget._productModel.catagory!),
            ),
            Text('$taka${widget._productModel.price!}',style: TextStyle(color: Colors.red,fontSize: 20),),
            Consumer<CartProvider>(
                builder:(context,provider,_)=> ElevatedButton(onPressed: (){
                  if(provider.isInCart(widget._productModel.id!))
                    {

                      provider.removeFromCart(widget._productModel.id!);
                    }
                  else
                    {
                      provider.addToCart(widget._productModel);
                    }


                }, child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart),
                  Text(provider.isInCart(widget._productModel.id!)?'Remove': 'Add',style: TextStyle(fontSize: 14,color: Colors.white),),
                ],
              ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrange,
                ),

              ),
            )

          ],
        ),

      ),
    );
  }
}
