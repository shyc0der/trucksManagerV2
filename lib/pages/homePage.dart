import 'package:flutter/material.dart';
import 'package:truck_manager/pages/color.dart';
import 'package:truck_manager/pages/loginPage.dart';
import 'package:truck_manager/pages/siginInPage.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}
class _HomePageState extends State<HomePage>{
  PageController controller= PageController();
  int curr=0;
  @override
  void initState() {
       super.initState();
       controller.addListener(() {
        setState(() {
         curr = controller.page?.floor() ?? 0; 
        });
        });

  }
 
  @override
  Widget build(BuildContext context) {
  return Scaffold(
   body: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Flexible(child: Container()),
      SizedBox(
        height: 430,
        child: Stack(
            children: [
            Container(
              width: double.infinity,
              height: 270,
              margin: const EdgeInsets.symmetric(horizontal:30 ,vertical: 20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 216, 235, 244),
                borderRadius: BorderRadius.circular(15),
              )
            ),
            PageView(
              scrollDirection: Axis.horizontal,
              controller: controller,
              reverse: false,
                 
              children: const [
                FrontPage(
                title: "Save Money" ,
                subTitle: "Cut out strenous costs of tracking and hard-to-use management software",
                assetPath: "assets/images/dollar.png",
                ),   
                 FrontPage(
                title: "Close The Page" ,
                subTitle: "Evaluate business performance for trucks to enhance sound decision making",
                assetPath: "assets/images/pieChart.png",
                ), 
                 FrontPage(
                title: "Easy To Use" ,
                subTitle: "We have designed a user interface that's intuitive and easy to use",
                assetPath: "assets/images/starMedal.png",
                ),
             
              ],
             
            ),
          ],
        ),
      ),
     const SizedBox(height: 10,),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
         Container(
          margin: const EdgeInsets.all(2),
          height: 8,
          width: 8,
          decoration: BoxDecoration(shape: BoxShape.circle,
          
          color: curr == 0 ? HexColor("#00877D") : Colors.greenAccent.withOpacity(.30)
          
          ),
         ),
          Container(            
          margin: const EdgeInsets.all(2),
          height: 8,
          width: 8,
          decoration:  BoxDecoration(shape: BoxShape.circle,
          color: curr == 1 ? HexColor("#00877D") : Colors.greenAccent.withOpacity(.25)
          ),
         ), Container(
          margin: const EdgeInsets.all(2),
          height: 8,
          width: 8,
          decoration:  BoxDecoration(shape: BoxShape.circle,
          color: curr == 2 ? HexColor("#00877D") : Colors.greenAccent.withOpacity(.25)
          ),
         ),
        ],
      ),
//const  SizedBox(height: 120,),
Flexible(flex: 4,child: Container(),),
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
                    MaterialPageRoute(builder: (context) => const SignInPage()),
                  );
            },
            child: const Text("Create an account" ,style: 
             TextStyle(color: Colors.white,
             fontWeight: FontWeight.bold
             ),),
            ),
        ),
      ),
      const  SizedBox(height: 20,),
      
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            
            backgroundColor: Theme.of(context).colorScheme.background,
            foregroundColor: Colors.white,
            shadowColor: Theme.of(context).colorScheme.background,
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
          child:  Text("Log in" ,style: 
           TextStyle(color: HexColor("#00877D"),
           fontWeight: FontWeight.bold
           ),),
          ),
      ),
        const  SizedBox(height: 20,),
    ],
   ),
 );
  }
   
}
class FrontPage extends StatelessWidget{
 const FrontPage({super.key, required this.title, this.icon, required this.subTitle, required this.assetPath});
   final String title;
   final String subTitle;
   final Icon? icon;
   final String assetPath;
  @override
  Widget build(BuildContext context) {
   return SizedBox(
    height: 300,    
   child: Column(
    children: [
      Flexible(flex: 12,child: Container(),),
     Image.asset(assetPath, height: 250,width: 250,),
      Flexible(flex: 2,child: Container(),),
   Text(title,style: const TextStyle(
   fontWeight: FontWeight.bold,
   fontSize: 19,
   color:  Color.fromARGB(255, 72, 68, 68)
   ),),
   
   Padding(
     padding: const EdgeInsets.symmetric(horizontal: 15.0),
     child: Text(subTitle ,
     textAlign: TextAlign.center,
     style: const TextStyle(
     fontSize: 15,
     color: Color.fromARGB(255, 27, 22, 22)
     ),),
   ),

   ]),
    );
  }

}