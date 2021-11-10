import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomrs_user_pannel/models/product_model.dart';


class FireStoreHelper{

  static const String _collectionProducts='Products';
  static const String _collectionCategories='Categories';
  static const String _collectionCustomer='Customers';
  static FirebaseFirestore _db=FirebaseFirestore.instance;


  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategories()=>_db.collection(_collectionCategories).orderBy('name').snapshots();
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts()=>_db.collection(_collectionProducts).where('isAvailable',isEqualTo: true).snapshots();

  static Future<QuerySnapshot<Map<String, dynamic>>> findCustomerByPhone(String phone){
    return _db.collection(_collectionCustomer).where('customerPhone',isEqualTo: phone).get();
  }

}