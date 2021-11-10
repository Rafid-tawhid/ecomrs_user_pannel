import 'package:ecomrs_user_pannel/models/customer_model.dart';
import 'package:ecomrs_user_pannel/pages/order_confirmation.dart';
import 'package:ecomrs_user_pannel/provider/customer_provider.dart';
import 'package:ecomrs_user_pannel/utilities/helper_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerInfoPage extends StatefulWidget {
  static const String routeName='/customer_page';

  @override
  _CustomerInfoPageState createState() => _CustomerInfoPageState();
}

class _CustomerInfoPageState extends State<CustomerInfoPage> {

  final _searchPhoneController =TextEditingController();
  final _nameController =TextEditingController();
  final _addressController =TextEditingController();
  final _phoneController =TextEditingController();
  final _emailController =TextEditingController();
  late CustomerProvider _customerProvider;
  CustomerModel? _customerModel=CustomerModel();
  final _fromkey=GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    _customerProvider=Provider.of<CustomerProvider>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _searchPhoneController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Information'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: (){
              saveCustomerInfoAndProceddtoOrderConfirmationPage();
            }, icon: Text('Next')),
          ),


        ],
      ),
      body: Column(
        children: [
          _findCustomerSection(),
          SizedBox(),
          _buildFromSectin(),
        ],
      )
    );
  }

  Widget _findCustomerSection(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Existing Customer',textAlign: TextAlign.center,),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(

            controller: _searchPhoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              suffix: IconButton(onPressed: (){
                _findExistingCustomer();
              }, icon: Icon(Icons.search)),
              hintText: 'Enter Phone Number',

            ),
          ),
        ),


  ],
      );
}
  Widget _buildFromSectin(){

    return Form(
      key: _fromkey,
      child: Expanded(
        child: ListView(
          children: [
            SizedBox(height: 10,),
            Text('New Customer',textAlign: TextAlign.center,style: TextStyle(fontSize: 18),),
            Divider(color: Colors.black,),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Customer Name'
                ),
                validator: (value){
                  return null;
                },
                onSaved: (value){
                  _customerModel!.customerName=value!;
                },

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Customer Phone'
                ),
                validator: (value){
                  return null;
                },
                onSaved: (value){
                  _customerModel!.customerPhone=value!;
                },

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: ' Customer Email'
                ),
                validator: (value){
                  return null;
                },
                onSaved: (value){
                  _customerModel!.customerEmail=value!;
                },

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: ' Address'
                ),
                validator: (value){
                  return null;
                },
                onSaved: (value){
                  _customerModel!.customerAddress=value!;
                },

              ),
            ),

          ],
        ),
      ),
    );
  }

  void _findExistingCustomer()async {
    Focus.of(context).unfocus();
    if(_searchPhoneController.text.isEmpty){
      showMessage(context, 'Provide a Phone Number');
      return;
    }
    _customerModel=await _customerProvider.findCustomer(_searchPhoneController.text);
    if(_customerModel!=null){
      showMessage(context, 'Found');
      setState(() {
        _nameController.text=_customerModel!.customerName!;
        _phoneController.text=_customerModel!.customerName!;
        _emailController.text=_customerModel!.customerEmail!;
        _addressController.text=_customerModel!.customerAddress!;
      });

    }
    else
      showMessage(context, 'Not Found');

  }

  void saveCustomerInfoAndProceddtoOrderConfirmationPage()async {
    if(_fromkey.currentState!.validate()){
      _fromkey.currentState!.save();
      if(_customerModel!.customerId==null){
        final customerId=await _customerProvider.addCustomer(_customerModel!);
        Navigator.pushNamed(context, OrderConfirmationPage.routeName,arguments: customerId);
      }
      else{
        await _customerProvider.updateCustomer(_customerModel!);
        Navigator.pushNamed(context, OrderConfirmationPage.routeName,arguments: _customerModel);
      }

    }
  }


}
