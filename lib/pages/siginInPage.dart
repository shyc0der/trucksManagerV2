import 'package:flutter/material.dart';
import 'package:truck_manager/pages/color.dart';
import 'package:truck_manager/pages/homePage.dart';
import 'package:truck_manager/pages/loginPage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool obsecured = true;
  final textFieldFocusNode = FocusNode();
  void toggleObsecure() {
    setState(() {
      obsecured = !obsecured;
      if (textFieldFocusNode.hasPrimaryFocus) return;
      textFieldFocusNode.canRequestFocus = false;
    });
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
            "Sign In",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 21, color: Colors.black),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            //controller: _usernameController,
            decoration: InputDecoration(
              hintText: 'Phone Number',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12.5),
              isDense: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      BorderSide(color: Colors.grey.shade400, width: .9)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      BorderSide(color: Colors.grey.shade400, width: .4)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: HexColor("#00877D"), width: 1)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            //controller: _passwordController,

            obscureText: obsecured ? true : false,

            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                  onTap: toggleObsecure,
                  child: Icon(
                    obsecured
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                  )),
              hintText: 'Password',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12.5),
              isDense: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      BorderSide(color: Colors.grey.shade400, width: .9)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      BorderSide(color: Colors.grey.shade400, width: .4)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: HexColor("#00877D"), width: 1)),
            ),
          ),
       Flexible(flex: 15,child: Container(),),
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
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInPage2()));
              },
              child: const Text(
                "Sign In",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Flexible(flex: 1,child: Container(),)
        ]),
      ),
    );
  }
}

class SignInPage2 extends StatefulWidget {
  const SignInPage2({super.key});

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
          TextField(
            //controller: _usernameController,
            decoration: InputDecoration(
              hintText: 'First Name',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12.5),
              isDense: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      BorderSide(color: Colors.grey.shade400, width: .9)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      BorderSide(color: Colors.grey.shade400, width: .4)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: HexColor("#00877D"), width: 1)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            //controller: _usernameController,
            decoration: InputDecoration(
              hintText: 'Last Name',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12.5),
              isDense: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      BorderSide(color: Colors.grey.shade400, width: .9)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      BorderSide(color: Colors.grey.shade400, width: .4)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: HexColor("#00877D"), width: 1)),
            ),
          ),
        Flexible(flex: 15,child: Container(),),
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInPage3()),
                );
              },
              child: const Text(
                "Next",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
  const SignInPage3({super.key});

  @override
  State<SignInPage3> createState() => _SignInPageState3();
}

class _SignInPageState3 extends State<SignInPage3> {
  bool obsecured = true;
  final textFieldFocusNode = FocusNode();
  void toggleObsecure() {
    setState(() {
      obsecured = !obsecured;
      if (textFieldFocusNode.hasPrimaryFocus) return;
      textFieldFocusNode.canRequestFocus = false;
    });
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
            "Enter your company details?",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 21, color: Colors.black),
          ),
          Text(
            "These will appear on all quotations, invoices and delivery notes",
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
          TextField(
            //controller: _usernameController,
            decoration: InputDecoration(
              hintText: 'Company Name',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12.5),
              isDense: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      BorderSide(color: Colors.grey.shade400, width: .9)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      BorderSide(color: Colors.grey.shade400, width: .4)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: HexColor("#00877D"), width: 1)),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            //controller: _usernameController,
            decoration: InputDecoration(
              hintText: 'Phone Number',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12.5),
              isDense: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      BorderSide(color: Colors.grey.shade400, width: .9)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      BorderSide(color: Colors.grey.shade400, width: .4)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: HexColor("#00877D"), width: 1)),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            //controller: _usernameController,
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12.5),
              isDense: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      BorderSide(color: Colors.grey.shade400, width: .9)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      BorderSide(color: Colors.grey.shade400, width: .4)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: HexColor("#00877D"), width: 1)),
            ),
          ),
         Flexible(flex: 15,child: Container(),),
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
              onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomePage()),
                );
              },
              child: const Text(
                "Finish",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
    body: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
       Flexible(flex: 3,child: Container()),
      SizedBox(
        height: 400,
        child: Stack(
         
            children: [
                 Container(
              width: double.infinity,
              height: 232,
              margin: const EdgeInsets.symmetric(horizontal:20 ,vertical: 10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 216, 235, 244),
                borderRadius: BorderRadius.circular(15),
              )
            ),
            
        const    FrontPage(
            title: "Welcome Felix" ,
            subTitle: "Thank You For Creating An Account With us. We are Glad You are here",
            assetPath: "assets/images/cofeeMg.png",
            ),   
          
          ],
        ),
      ),
   
  Flexible(flex: 15,child: Container(),),
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
                borderRadius: BorderRadius.circular(32)
              ),
              minimumSize: const Size(700, 50)
            ),
            onPressed: (){
               Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
            },
            child: const Text("Start Using The App" ,style: 
             TextStyle(color: Colors.white,
             fontWeight: FontWeight.bold
             ),),
            ),
        ),
      ),
        Flexible(child: Container()),
      ],
   ),
 );
  }
}
