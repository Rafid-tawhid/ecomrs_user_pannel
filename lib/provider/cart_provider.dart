import 'package:ecomrs_user_pannel/models/cart_model.dart';
import 'package:ecomrs_user_pannel/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier{

  List<CartModel> cartList=[];
  
  void addToCart(ProductModel productModel){
    cartList.add(CartModel(productId: productModel.id!,productName: productModel.name!,price: productModel.price!));

    notifyListeners();
  }

  void removeFromCart(String id)
  {
    final cartModel=cartList.firstWhere((cartModel) => cartModel.productId==id);
    cartList.remove(cartModel);
    notifyListeners();
  }

  bool isInCart(String id){
    bool tag=false;
    for(var c in cartList){
      if(c.productId==id)
        {
          tag =true;
          break;
        }
    }
    return tag;
  }

  int get totalsItemsInCart=>cartList.length;
  num getPriceWithQty(CartModel cartModel)=>cartModel.price*cartModel.qty;


  num get cartItemsTotalPrice{
    num total=0;
    cartList.forEach((element) {
      total+=element.price*element.qty;

    });
    return total;
  }
  void decreaseQty(CartModel cartModel){
    var index=cartList.indexOf(cartModel);
    if(cartList[index].qty>1)
      {
        cartList[index].qty -=1;

      }
    notifyListeners();
  }
  void increseQty(CartModel cartModel){
    var index=cartList.indexOf(cartModel);

      cartList[index].qty +=1;
      notifyListeners();
  }

}

