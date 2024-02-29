// ignore_for_file: use_build_context_synchronously


import 'package:flutter/material.dart';


import 'package:get/get_utils/src/get_utils/get_utils.dart';


import 'package:truck_manager/components.dart';


import 'package:truck_manager/pages/color.dart';


import 'package:truck_manager/pages/homePage.dart';


import 'package:truck_manager/pages/loginPage.dart';


import 'package:truck_manager/pages/models/fireBaseModel.dart';


import 'package:truck_manager/pages/models/responseModel.dart';


import 'package:truck_manager/pages/models/tenantsModel.dart';


import 'package:truck_manager/pages/models/userModel.dart';


import 'package:truck_manager/pages/modules/tenantsModules.dart';


import 'package:truck_manager/pages/modules/userModules.dart';


import 'package:truck_manager/pages/ui/widgets/input_fields.dart';


class SignInPage extends StatefulWidget {

  const SignInPage({super.key});


  @override

  State<SignInPage> createState() => _SignInPageState();

}


class _SignInPageState extends State<SignInPage> {

  final UserModel userModel = UserModel();


  bool obsecured = true;


  final textFieldFocusNode = FocusNode();


  late final TextEditingController emailController;


  late final TextEditingController passwordController;


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


  final TenantModules _tenantModules = TenantModules();


  bool errExist = false;


  bool tenantError = false;


  bool isLoading = false;


  bool emailError = false;


  bool passwordError = false;


  bool passwordInvalid = false;


  bool emailInvalid = false;


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

            "Sign In",

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

          const SizedBox(

            height: 30,

          ),

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


                      errExist = false;

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

          Flexible(

            flex: 15,

            child: Container(),

          ),

          Text(

            "By Signing Up,You Agree To Our Terms of use and privacy policy",

            style: TextStyle(

              color: HexColor("#00877D"),


              decorationColor: HexColor("#00877D"), // optional


              decorationThickness: 2, // optional


              //decorationStyle: TextDecorationStyle.dashed,

            ),

          ),

          const SizedBox(

            height: 10,

          ),

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

                      userModel.email = emailController.text;


                      userModel.tenantId = tenantsModel?.tenantId;


                      if (tenantsModel == null ||

                          tenantsModel!.tenantId!.isEmpty ||

                          tenantsModel!.tenantId == "") {

                        setState(() {

                          tenantError = true;


                          errExist = true;

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


                          errExist = true;

                        });

                      }


                      if (!GetUtils.isEmail(emailController.text)) {

                        setState(() {

                          emailInvalid = true;


                          errExist = true;

                        });

                      }


                      if (passwordController.text.isEmpty) {

                        setState(() {

                          passwordError = true;


                          errExist = true;

                        });

                      }


                      if (!errExist) {

                        // login


                        setState(() {

                          isLoading = true;

                        });


                        // final res = ResponseModel(ResponseType.success,


                        //     "LgvHm1DeE5YTgAG7nBDlFrS3T9x1");


                        final res = await FirebaseUserModule.createUser(

                            emailController.text,

                            passwordController.text,

                            tenantsModel?.tenantId);




                        if (res.status == ResponseType.success) {

                          // get user


                          //  await userModule.setCurrentUser(_res.body.toString());


                          userModel.id = res.body.toString();


                          //Get.offAndToNamed('/');


                          await Future.delayed(const Duration(seconds: 1));


                          //Get.off(const HomePage());


                          await Navigator.push(

                              context,

                              MaterialPageRoute(

                                  builder: (context) => SignInPage2(

                                      user: userModel,

                                      tenantsModel: tenantsModel)));

                        }


                        if (res.body == 'email-already-in-use') {

                          setState(() {

                            //emailError = true;


                            emailInvalid = true;

                          });


                          ScaffoldMessenger.of(context)

                              .showSnackBar(const SnackBar(

                            backgroundColor: Colors.red,

                            content: Text("Email Already In Use"),

                          ));


                          setState(() {

                            isLoading = false;

                          });


                          return;

                        }


                        if (res.body == 'weak-password') {

                          setState(() {

                            // passwordError = true;


                            passwordInvalid = true;

                          });


                          ScaffoldMessenger.of(context)

                              .showSnackBar(const SnackBar(

                            backgroundColor: Colors.red,

                            content: Text(" Weak Password"),

                          ));


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


                          setState(() {

                            isLoading = false;

                          });

                        }


                        return;

                      }


                      setState(() {

                        isLoading = false;

                      });

                    },

              child: isLoading

                  ? const CircularProgressIndicator()

                  : const Text(

                      "Sign In",

                      style: TextStyle(

                          color: Colors.white, fontWeight: FontWeight.bold),

                    ),

            ),

          ),

          Flexible(

            flex: 1,

            child: Container(),

          )

        ]),

      ),

    );

  }

}


class SignInPage2 extends StatefulWidget {

  const SignInPage2(

      {required this.user, super.key, required this.tenantsModel});


  final UserModel? user;


  final TenantsModel? tenantsModel;


  @override

  State<SignInPage2> createState() => _SignInPageState2();

}


class _SignInPageState2 extends State<SignInPage2> {

  bool obsecured = true;


  final textFieldFocusNode = FocusNode();


  void toggleObsecure() {

    setState(() {

      obsecured = !obsecured;


      if (textFieldFocusNode.hasPrimaryFocus) return;


      textFieldFocusNode.canRequestFocus = false;

    });

  }


  late final TextEditingController firstNameController;


  late final TextEditingController lastNameController;


  bool firstNameError = false;


  bool firstNameInvalid = false;


  bool lastNameError = false;


  bool lastNameInvalid = false;


  bool isLoading = false;


  bool errorExist = false;


  @override

  void initState() {

    firstNameController = TextEditingController();


    lastNameController = TextEditingController();


    super.initState();

  }


  @override

  void dispose() {

    firstNameController.dispose();


    lastNameController.dispose();


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

            "Whats Your Name?",

            style: TextStyle(

                fontWeight: FontWeight.bold, fontSize: 21, color: Colors.black),

          ),

          Text(

            "This is how your colleagues will be able to recognise you.You can change it at any time.",

            style: TextStyle(

              color: HexColor("#00877D"),


              decorationColor: HexColor("#00877D"), // optional


              decorationThickness: 2, // optional


              //decorationStyle: TextDecorationStyle.dashed,

            ),

          ),

          const SizedBox(

            height: 20,

          ),

          InputField2("First Name", firstNameController, firstNameError, false,

              isObsecured: false,

              invalid: firstNameInvalid, onChanged: (String val) {

            if (val.isNotEmpty) {

              setState(() {

                firstNameError = false;

                errorExist = false;

                firstNameInvalid = false;

              });

            }

          }),

          const SizedBox(

            height: 20,

          ),

          const SizedBox(

            height: 10,

          ),

          InputField2("Last Name", lastNameController, lastNameError, false,

              isObsecured: false,

              invalid: lastNameInvalid, onChanged: (String val) {

            if (val.isNotEmpty) {

              setState(() {

                lastNameError = false;


                errorExist = false;


                lastNameInvalid = false;

              });

            }

          }),

          const SizedBox(

            height: 30,

          ),

          Flexible(

            flex: 15,

            child: Container(),

          ),

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

                      widget.user?.firstName = firstNameController.text;


                      widget.user?.lastName = lastNameController.text;

                      if (firstNameController.text.isEmpty) {

                        errorExist = true;


                        setState(() {

                          firstNameError = true;

                        });

                      }


                      if (lastNameController.text.isEmpty) {

                        errorExist = true;


                        setState(() {

                          lastNameError = true;

                        });

                      }


                      if (!errorExist) {

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                              builder: (context) => SignInPage3(

                                  user: widget.user,

                                  tenantsModel: widget.tenantsModel)),

                        );

                      }

                    },

              child: isLoading

                  ? const CircularProgressIndicator()

                  : const Text(

                      "Next",

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


class SignInPage3 extends StatefulWidget {

  const SignInPage3(

      {required this.user, super.key, required this.tenantsModel});


  final UserModel? user;


  final TenantsModel? tenantsModel;


  @override

  State<SignInPage3> createState() => _SignInPageState3();

}


class _SignInPageState3 extends State<SignInPage3> {

  bool obsecured = true;


  final textFieldFocusNode = FocusNode();


  late final TextEditingController idNumberController;


  late final TextEditingController phoneNumberController;


  late final TextEditingController addressController;


  final UserModule userModule = UserModule();


  bool errorExist = false;


  bool isLoading = false;


  bool idNumberError = false;


  bool idNumberInvalid = false;


  bool phoneNumberError = false;


  bool phoneNumberInvalid = false;


  bool addressError = false;


  bool addressInvalid = false;


  void toggleObsecure() {

    setState(() {

      obsecured = !obsecured;


      if (textFieldFocusNode.hasPrimaryFocus) return;


      textFieldFocusNode.canRequestFocus = false;

    });

  }


  @override

  void initState() {

    idNumberController = TextEditingController();


    phoneNumberController = TextEditingController();


    addressController = TextEditingController();


    super.initState();

  }


  @override

  void dispose() {

    super.dispose();


    idNumberController.dispose();


    phoneNumberController.dispose();


    addressController.dispose();

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

            "Add Extra Details About yourself so we can activate your account",

            style: TextStyle(

                fontWeight: FontWeight.bold, fontSize: 21, color: Colors.black),

          ),


          // Text(


          //   "These will appear on all quotations, invoices and delivery notes",


          //   style: TextStyle(


          //     color: HexColor("#00877D"),


          //     decorationColor: HexColor("#00877D"), // optional


          //     decorationThickness: 2, // optional


          //     //decorationStyle: TextDecorationStyle.dashed,


          //   ),


          // ),


          const SizedBox(

            height: 20,

          ),

          InputField2(
              "Phone Number", phoneNumberController, phoneNumberError, false,

              isObsecured: false,

              invalid: phoneNumberInvalid, onChanged: (String val) {

            if (val.isNotEmpty) {

              setState(() {

                phoneNumberError = false;


                errorExist = false;


                phoneNumberInvalid = false;

              });

            }

          }),

          const SizedBox(

            height: 20,

          ),
          InputField2("ID Number", idNumberController, idNumberError, false,

              isObsecured: false,

              invalid: idNumberInvalid, onChanged: (String val) {

            if (val.isNotEmpty) {

              setState(() {

                idNumberError = false;


                errorExist = false;


                idNumberInvalid = false;

              });

            }

          }),


          const SizedBox(

            height: 30,

          ),
          InputField2("Address", addressController, addressError, false,
              isObsecured: false,
              invalid: addressInvalid,
              onChanged: (String val) {}),


          Flexible(

            flex: 15,

            child: Container(),

          ),


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

                      widget.user?.idNumber = idNumberController.text;


                      widget.user?.address = addressController.text;


                      widget.user?.phoneNo = phoneNumberController.text;


                      if (idNumberController.text.isEmpty) {

                        errorExist = true;


                        setState(() {

                          idNumberError = true;

                        });

                      }


                      if (phoneNumberController.text.isEmpty) {

                        errorExist = true;


                        setState(() {

                          phoneNumberError = true;

                        });

                      }


                      if (!errorExist) {

                   await userModule.createUser(

                            widget.user!.id!, widget.user!);




                        Navigator.push(

                          context,

                          MaterialPageRoute(

                              builder: (context) => WelcomePage(userModel: widget.user,)),

                        );

                      }

                    },

              child: isLoading

                  ? const CircularProgressIndicator()

                  : const Text(

                      "Finish",

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


class WelcomePage extends StatelessWidget {

  const WelcomePage({super.key, this.userModel});


  final UserModel? userModel;

  @override

  Widget build(BuildContext context) {

    // TODO: implement build


    return Scaffold(

      body: Column(

        mainAxisAlignment: MainAxisAlignment.start,

        children: [

          Flexible(flex: 3, child: Container()),

          SizedBox(

            height: 400,

            child: Stack(

              children: [

                Container(

                    width: double.infinity,

                    height: 232,

                    margin: const EdgeInsets.symmetric(

                        horizontal: 20, vertical: 10),

                    decoration: BoxDecoration(

                      color: const Color.fromARGB(255, 216, 235, 244),

                      borderRadius: BorderRadius.circular(15),

                    )),

                 FrontPage(

                  title: "Welcome ${userModel?.firstName} ${userModel?.lastName}",

                  subTitle:

                      "Thank You For Creating An Account With us. We are Glad You are here",

                  assetPath: "assets/images/cofeeMg.png",

                ),

              ],

            ),

          ),

          Flexible(

            flex: 15,

            child: Container(),

          ),

          Align(

            alignment: Alignment.bottomCenter,

            child: Padding(

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

                onPressed: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(builder: (context) => const LoginPage()),

                  );

                },

                child: const Text(

                  "Start Using The App",

                  style: TextStyle(

                      color: Colors.white, fontWeight: FontWeight.bold),

                ),

              ),

            ),

          ),

          Flexible(child: Container()),

        ],

      ),

    );

  }

}

