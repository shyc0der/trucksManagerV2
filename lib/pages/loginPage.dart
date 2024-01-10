// ignore_for_file: use_build_context_synchronously


import 'package:flutter/material.dart';


import 'package:get/get.dart';


import 'package:truck_manager/components.dart';


import 'package:truck_manager/pages/color.dart';


import 'package:truck_manager/pages/models/fireBaseModel.dart';


import 'package:truck_manager/pages/models/responseModel.dart';


import 'package:truck_manager/pages/models/tenantsModel.dart';


import 'package:truck_manager/pages/modules/tenantsModules.dart';


import 'package:truck_manager/pages/modules/userModules.dart';


import 'package:truck_manager/pages/ui/pages/home_page.dart';


import 'package:truck_manager/pages/ui/widgets/input_fields.dart';


class LoginPage extends StatefulWidget {

  const LoginPage({super.key});


  @override

  State<LoginPage> createState() => _LoginPageState();

}


class _LoginPageState extends State<LoginPage> {

  bool obsecured = true;


  bool isLoading = false;


  bool emailError = false;


  bool errorExists = false;
  
  bool tenantError = false;


  bool passwordError = false;


  bool passwordInvalid = false;


  bool emailInvalid = false;


  final textFieldFocusNode = FocusNode();


  late final TextEditingController emailController;


  late final TextEditingController passwordController;


  final TenantModules _tenantModules = TenantModules();


  final UserModule userModule = Get.find<UserModule>();


  TenantsModel? tenantsModel;


  void toggleObsecure() {

    setState(() {

      obsecured = !obsecured;


      if (textFieldFocusNode.hasPrimaryFocus) return;


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

        leading: IconButton(

            onPressed: () {

              Navigator.pop(context);

            },

            icon: const Icon(Icons.arrow_back_rounded)),

      ),

      body: Padding(

        padding: const EdgeInsets.symmetric(horizontal: 12.0),

        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          const Text(

            "Log in",

            style: TextStyle(

                fontWeight: FontWeight.bold, fontSize: 21, color: Colors.black),

          ),


          const SizedBox(

            height: 20,

          ),


          InputField2("Email", emailController, emailError, false,

              isObsecured: false,

              invalid: emailInvalid, onChanged: (String val) {

            if (val.isNotEmpty) {

              setState(() {

                emailError = false;


                emailInvalid = false;

              });

            }

          }),


          const SizedBox(

            height: 20,

          ),


          const SizedBox(

            height: 10,

          ),


          // password


          InputField2("Password", passwordController, passwordError, obsecured,

              toggleObsecure: toggleObsecure,

              isHidden: true,

              isObsecured: true,

              invalid: passwordInvalid, onChanged: (String val) {

            if (val.isNotEmpty) {

              setState(() {

                passwordError = false;


                passwordInvalid = false;

              });

            }

          }),


          const SizedBox(height: 30),


          // Drop Down


          StreamBuilder<List<TenantsModel>>(

            stream: _tenantModules

                .fetchAllTenants(), // Assuming this is your Stream<List<TenantsModel>>


            builder: (context, AsyncSnapshot<List<TenantsModel>> snapshot) {

              if (snapshot.connectionState == ConnectionState.waiting) {

                // The stream hasn't emitted data yet.


                return const CircularProgressIndicator();

              } else if (snapshot.hasError) {

                // Handle errors from the stream.


                return Text('Error: ${snapshot.error}');

              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {

                // The stream has emitted data, but it's empty.


                return const Text('No tenants available.');

              } else {

                // The stream has emitted data, and it's not empty.


                return AppDropdownInput<TenantsModel?>(

                  hintText: "Please Select Your Company Below",

                  options: [

                    TenantsModel(name: "", database: "", tenantId: "", id: ""),

                    ...snapshot.data!

                  ],

                  getLabel: (TenantsModel? tenant) => tenant!.name!,

                  value: tenantsModel,

                  onChanged: (TenantsModel? value) {

                    setState(() {

                      tenantsModel = value;
                     
                      tenantError = false;


                      errorExists = false;


                    });

                  },

                );

              }

            },

          ),

       tenantError == true

              ? Container(

                  child: Text(

                    "Ensure To Select A Tenant !!!",

                    style: TextStyle(color: Colors.red),

                  ),

                )

              : Container(),
          const SizedBox(

            height: 30,

          ),


          const SizedBox(

            height: 20,

          ),


          Text(

            "I've forgotten my password",

            style: TextStyle(

              color: HexColor("#00877D"),


              decoration: TextDecoration.underline,


              decorationColor: HexColor("#00877D"), // optional


              decorationThickness: 2, // optional


              //decorationStyle: TextDecorationStyle.dashed,

            ),

          ),


          Flexible(flex: 15, child: Container()),


          Padding(

            padding: const EdgeInsets.symmetric(horizontal: 8.0),

            child: ElevatedButton(

              style: ElevatedButton.styleFrom(

                  backgroundColor: HexColor("#00877D"),

                  foregroundColor: Colors.white,

                  shadowColor: HexColor("#00877D"),

                  elevation: 3,

                  shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(32)),

                  minimumSize: const Size(700, 50)),

              onPressed: isLoading

                  ? null

                  : () async {
                     if (tenantsModel == null ||

                          tenantsModel!.tenantId!.isEmpty ||

                          tenantsModel!.tenantId == "") {

                        setState(() {

                          tenantError = true;


                          errorExists = true;

                        });


                        ScaffoldMessenger.of(context)

                            .showSnackBar(const SnackBar(

                          backgroundColor: Colors.red,

                          content: Text("Ensure To select A tenant"),

                        ));



                      }

                      if (emailController.text.isEmpty) {

                        setState(() {

                          emailError = true;


                          errorExists = true;

                        });

                      }


                      if (passwordController.text.isEmpty) {

                        setState(() {

                          passwordError = true;


                          errorExists = true;

                        });

                      }


                      if (!errorExists) {

                        // login

                        setState(() {

                          isLoading = true;

                        });

                        final res = await FirebaseUserModule.login(
                            emailController.text,
                            passwordController.text,
                            tenantsModel?.tenantId);

                        if (res.status == ResponseType.success) {
                          // get user

                          // await userModule.setCurrentUser(_res.body.toString());

                          //Get.offAndToNamed('/');

                          await userModule.setCurrentUser(res.body.toString());

                          await Future.delayed(const Duration(seconds: 1));

                          //Get.off(const HomePage());

                          await Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const HomePage2())),
                                  (Route<dynamic> route) => false)
                                  ;
                        }

                        if (res.body == 'user-not-found') {
                          setState(() {
                            emailInvalid = true;
                          });
                           setState(() {

                            isLoading = false;

                          });

                        return;
                        
                        }

                        if (res.body == 'wrong-password') {
                          setState(() {
                            passwordInvalid = true;
                          });
                            setState(() {

                            isLoading = false;

                          });

                        return;
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                                "Ensure To Select Your Tenant Or Check Your Internet"),
                          ));
                        }

                        setState(() {
                          isLoading = false;
                        });
                      }
                    },

              child: isLoading

                  ? const CircularProgressIndicator()

                  : const Text(

                      "Log In",

                      style: TextStyle(

                          color: Colors.white, fontWeight: FontWeight.bold),

                    ),

            ),

          ),


          Flexible(child: Container())

        ]),

      ),

    );

  }

}

