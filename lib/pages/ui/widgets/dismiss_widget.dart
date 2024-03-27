import 'package:flutter/material.dart';
import 'package:get/get.dart';


Future<bool?> dismissWidget (String label,String type){
  return Get.dialog<bool?>(
                        
                      Center(
                        child: Dialog(
                          backgroundColor: Color.fromARGB(255, 243, 246, 245),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 26.0,bottom: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/deleteIcon.png", height: 40,width: 40,),
                               const SizedBox(height: 10,),
                                  Text("Delete $type \n",
                                  style: const TextStyle(fontSize: 18,fontWeight:FontWeight.bold,color: Colors.red)
                                  ),
                                  const Text('Are you sure you want to delete \n ',style:TextStyle(
                                        color: Colors.black,
                                        fontSize: 18
                                      ,
                                      ),),
                                      Text('$type $label', style: const TextStyle(
                                        fontWeight:FontWeight.bold,color: Colors.red,
                                        fontSize: 18
                                      )
                                  ),
                                  const SizedBox(height: 10,),
                                  // RichText(text: TextSpan(
                                  //   text:"Delete $type \n",
                                  //   style: const TextStyle(fontSize: 18,fontWeight:FontWeight.bold,color: Colors.red),
                                  //   children: <TextSpan>[
                                  //     const TextSpan(text: 'Are you sure you want to \n ',style:TextStyle(
                                  //       color: Colors.black,
                                  //       fontSize: 18
                                  //     ,
                                  //     ),                                    
                                  //     ),
                                  //    TextSpan(text: '$type ', style: const TextStyle(
                                  //       fontWeight:FontWeight.bold,color: Colors.red,
                                  //       fontSize: 18
                                  //     ,
                                  //     ),                                    
                                  //     ),
                                  //     TextSpan(text: label ,style:
                                      
                                  //     const TextStyle(
                                  //       color: Colors.black87,
                                  //         fontSize: 18))
                                  //     ,
                                  //   ]
                                  //    ),),
                                  // //rText("Are you sure you want to DELETE ${expense.name}?"),
                                  
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10,),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // yes
                                         ElevatedButton(
                                          onPressed: ()=> Get.back(result: false), child: 
                                          const Text('Cancel',
                                          style: TextStyle(fontSize: 18)
                                          ),
                                          // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
                                        ),
                                        ElevatedButton(
                                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),),
                                          onPressed: ()=> Get.back(result: true), child: 
                                       const Text('Yes delete!', 
                                        style:  TextStyle(color: Colors.white,fontSize: 18),)),
                                                    
                                        // no
                                       
                                                    
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      )
  );

}