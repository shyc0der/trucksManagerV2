import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:truck_manager/pages/color.dart';
import 'package:truck_manager/pages/models/fireBaseModel.dart';
import 'package:truck_manager/pages/models/responseModel.dart';
import 'package:truck_manager/pages/orders/ordersPage.dart';

class LoginPage extends StatefulWidget{
  @override
  State<LoginPage> createState() => _LoginPageState();

}
class _LoginPageState extends State<LoginPage>{
  bool obsecured = true;
  bool isLoading = false;
  bool emailError = false;
  bool passwordError = false;
  bool passwordInvalid= false;
  bool emailInvalid= false;
  final textFieldFocusNode =FocusNode();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  void toggleObsecure(){
    setState(() {
      obsecured = !obsecured;
      if(textFieldFocusNode.hasPrimaryFocus) return;
      textFieldFocusNode.canRequestFocus = false;
    });
  }

@override
  void initState() {
   emailController = TextEditingController();
   passwordController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      
       leading:  IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_rounded)),
      ),
   body:  Padding(
     padding: const EdgeInsets.symmetric(horizontal: 12.0),
     child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         const Text("Log in",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21,color: Colors.black),),
            
            const SizedBox(height: 20,),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12.5),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade400, width: .9)
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade400, width: .4)
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:  BorderSide(color: HexColor("#00877D"), width: 1)
                ),
              ),
            ),
            const SizedBox(height: 20,),
      
            const SizedBox(height: 10,),
            TextField(
              controller: passwordController,
              
              obscureText: obsecured ? true : false,
              
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: toggleObsecure,
                  child:  Icon(
                    obsecured ? Icons.visibility_rounded :
                    Icons.visibility_off_rounded,)),
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12.5),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade400, width: .9)
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade400, width: .4)
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:  BorderSide(color: HexColor("#00877D"), width: 1)
                ),
              ),
            ),
           
      
            const SizedBox(height: 30,),
              const SizedBox(height: 20,),
             Text("I've forgotten my password",
    style: TextStyle(color: HexColor("#00877D"),
    decoration: TextDecoration.underline,
    decorationColor: HexColor("#00877D"), // optional
    decorationThickness: 2, // optional
    //decorationStyle: TextDecorationStyle.dashed, 
            ),),
          Flexible(flex: 15, child: Container()),
        Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            
            backgroundColor:  HexColor("#00877D"),
            foregroundColor: Colors.white,
            shadowColor: HexColor("#00877D"),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32)
            ),
            minimumSize: const Size(700, 50)
          ),
          onPressed: isLoading ? null : () async{
            bool errorExists = false;
         if(emailController.text.isEmpty){
          setState(() {
            emailError = true;
            errorExists = true;
          });          
         }
          if(passwordController.text.isEmpty){
          setState(() {
            passwordError = true;
            errorExists = true;
          });          
         }
         final res = await FirebaseUserModule.login
         (emailController.text, passwordController.text);
         await Future.delayed(const Duration(seconds: 4));
       if (res.status == ResponseType.success) {
                          // get user

                         // await userModule.setCurrentUser(_res.body.toString());
                          
                          //Get.offAndToNamed('/');
                          await Future.delayed(const Duration(seconds: 3));
                          //Get.off(const HomePage());
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>  OrdersPage())));
                        }
                        if (res.body == 'user-not-found') {
                          setState(() {
                            emailInvalid = true;
                          });
                        }
                        if (res.body == 'wrong-password') {
                          setState(() {
                            passwordInvalid = true;
                          });
                        }

                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Log In" ,style: 
           TextStyle(color: Colors.white,
           fontWeight: FontWeight.bold
           ),),
          ),
              ),
   
      Flexible(child: Container())
     ]),
   ),
 );
  }
   
}