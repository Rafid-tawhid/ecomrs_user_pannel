import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseAuthServices {
  static FirebaseAuth _auth=FirebaseAuth.instance;
  static User? get currentUser => _auth.currentUser;

  static Future<User?> loginUser(String email,String pass) async{
  final result= await _auth.signInWithEmailAndPassword(email: email, password: pass);
  return result.user;

  }
  static Future<User?> registerUser(String email,String pass) async{
    final result= await _auth.createUserWithEmailAndPassword(email: email, password: pass);
    return result.user;

  }
  static Future<void> logoutUser(){
    return _auth.signOut();
  }


}