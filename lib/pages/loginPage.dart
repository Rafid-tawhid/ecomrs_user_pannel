
import 'package:ecomrs_user_pannel/auth/firebase_auth.dart';
import 'package:ecomrs_user_pannel/pages/product_list_page.dart';
import 'package:ecomrs_user_pannel/provider/product_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const String routeName='/login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _email,_pass;
  String _errorMsg='';
  bool isLogin=true;

  final form_key=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login Page'),
        ),
        body: Center(
          child: Container(
            child: Form(
              key: form_key,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(15),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Center(child: Text('USER LOGIN',style: TextStyle(fontSize: 25,letterSpacing: 2),)),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value){
                        if(value==null || value.isEmpty)
                          return 'This field must not be empty';
                        return null;
                      },
                      onSaved: (value){
                        _email=value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        border: OutlineInputBorder(),

                      ),
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      obscureText: true,
                      validator: (value){
                        if(value==null || value.isEmpty)
                          return 'This field must not be empty';
                        return null;
                      },
                      onSaved: (value){
                        _pass=value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),

                      ),
                    ),
                    SizedBox(height: 40,),
                    Center(child: ElevatedButton(onPressed: (){
                      isLogin=true;
                      _userLogin();
                    }, child: Text('Login'),)),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Center(child: Text(_errorMsg,style: TextStyle(fontSize: 15,color: Colors.red),)),
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('New user?'),
                        SizedBox(width: 10,),
                        TextButton(onPressed: (){
                          isLogin=false;
                          _userLogin();
                        }, child: Text('Register'))
                      ],
                    )



                  ],
            )),
          ),
        ),
      ),
    );
  }

  void _userLogin() async{
    User? user;
    if(form_key.currentState!.validate())
      {
        form_key.currentState!.save();

        try{
          if(isLogin){
            user = await FirebaseAuthServices.loginUser(_email!, _pass!);
          }
          else
            {
              user = await FirebaseAuthServices.registerUser(_email!, _pass!);
            }
          if(user != null)
            {
              Navigator.pushReplacementNamed(context, ProductListPage.routeName);
            }

        }
        on FirebaseAuthException catch(e){
          setState(() {
            _errorMsg=e.message!;
          });
        }
      }
  }
}
