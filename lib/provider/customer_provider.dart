import 'package:ecomrs_user_pannel/db/firestore_helper.dart';
import 'package:ecomrs_user_pannel/models/customer_model.dart';
import 'package:ecomrs_user_pannel/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class CustomerProvider extends ChangeNotifier{

  // List<String> categorieList=[];
  // List<ProductModel> productList=[];



  Future<CustomerModel?> findCustomer(String? phone)async{

    final snapshot= await FireStoreHelper.findCustomerByPhone(phone!);
    if(snapshot.docs.isEmpty){
      final customerModel=CustomerModel.fromMap(snapshot.docs.first.data());
      return customerModel;
    }
    return null;
  }
  Future<String?> addCustomer(CustomerModel customerModel)async{
    return '';
  }
  Future<void> updateCustomer(CustomerModel customerModel)async{
  }


}