import 'package:flutter/material.dart';
import 'package:truck_manager/pages/color.dart';

class SignInPage extends StatefulWidget{
  @override
  State<SignInPage> createState() => _SignInPageState();

}
class _SignInPageState extends State<SignInPage>{
  bool obsecured = true;
  final textFieldFocusNode =FocusNode();
  void toggleObsecure(){
    setState(() {
      obsecured = !obsecured;
      if(textFieldFocusNode.hasPrimaryFocus) return;
      textFieldFocusNode.canRequestFocus = false;
    });
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(leading: const Icon(Icons.arrow_back_rounded),),
   body:  Padding(
     padding: const EdgeInsets.symmetric(horizontal: 12.0),
     child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         const Text("Sign In",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21,color: Colors.black),),
            
            const SizedBox(height: 20,),
            TextField(
              //controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Phone Number',
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
              //controller: _passwordController,
              
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
              const  SizedBox(height: 230,),
             Text("By Signing Up,You Agree To Our Terms of use and privacy policy",
    style: TextStyle(color: HexColor("#00877D"),
    decorationColor: HexColor("#00877D"), // optional
    decorationThickness: 2, // optional
    //decorationStyle: TextDecorationStyle.dashed, 
            ),),
           const SizedBox(height: 10,),
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
            minimumSize: const Size(700, 60)
          ),
          onPressed: (){},
          child: const Text("Sign In" ,style: 
           TextStyle(color: Colors.white,
           fontWeight: FontWeight.bold
           ),),
          ),
              ),
   
      
     ]),
   ),
 );
  }
   
}