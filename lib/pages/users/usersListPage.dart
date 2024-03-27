import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truck_manager/components.dart';
import 'package:truck_manager/pages/models/userModel.dart';
import 'package:truck_manager/pages/modules/userModules.dart';
import 'package:truck_manager/pages/ui/pages/users/addCustomer.dart';
import 'package:truck_manager/pages/ui/pages/users/add_user_widget.dart';
import 'package:truck_manager/pages/ui/widgets/dismiss_widget.dart';


class UsersListPage extends StatefulWidget {

  const UsersListPage({super.key});


  @override

  State<UsersListPage> createState() => _UsersListPageState();

}


class _UsersListPageState extends State<UsersListPage>

    with SingleTickerProviderStateMixin {
  late final TextEditingController _searchTextController;
  UserModule userModule = Get.find<UserModule>();
    bool isCustomer = false;

  bool isDriver = false;

  @override

  void initState() {

    super.initState();

    _searchTextController = TextEditingController();

  }
Future<bool> _dismissDialog(UserModel user) async {
    bool? delete = await dismissWidget('${user.firstName}','Customer');
    bool shouldDelete = delete == true;
   
    
   if (shouldDelete) {
      //if Expense Type does exists one cannnot delete an expense Type that is already tied to an expense

      await userModule.deleteUser(user.id ?? '',
       {
        "isDeleted": true,
        "isActive": false
        }
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("User  Deleted!"),
      ));
    }
      // delete from server
    

    return shouldDelete;
  }


  @override

  Widget build(BuildContext context) {

    return Scaffold(
         floatingActionButton: CircleAvatar(

          backgroundColor: Colors.green,

          radius: 30,

          child: IconButton(

            onPressed: () {

              Navigator.push(

                  context,

                  MaterialPageRoute(

                      builder: (context) => const AddUserWidget()));

            },

            icon: const Icon(Icons.add),

          )),

      body: 
       StreamBuilder<List<UserModel?>>(
          
                  stream: userModule.fetchUsersWhere(isCustomer, isDriver,userModule.currentUser.value.tenantId),
          
                  builder: (context, snapshot) {
          
                    var users = snapshot.data ?? [];
          
                    if (snapshot.hasError) {
          
                      return Text('Error = ${snapshot.error}');
          
                    }
          
                    if (snapshot.hasData) {
          
                      var displayJobs = snapshot.data!;
          
                      return   Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                        child: Column(
                                  
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  
                                    children: [
                                  
                                      //Container with Users
                                  
                                      Padding(
                                  
                                        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                                  
                                        child: Container(
                                  
                                          height: 130,
                                          padding: const EdgeInsets.only(top: 10, bottom: 15),
                                  
                                          width: MediaQuery.of(context).size.height * 0.50,
                                  
                                          decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 243, 216, 234),
                        borderRadius: BorderRadius.circular(8)),
                                  
                                          child:  Padding(
                                  
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  
                                            child: 
                                            Column(
                                  
                        crossAxisAlignment: CrossAxisAlignment.start,
                                  
                        children: [
                                  
                          const Text(
                            "My Users",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                          ),
                                  
                          Text(
                            users.length.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                                  
                          ),
                                  
                        ],
                                  
                                            ),
                                  
                                          ),
                                  
                                        ),
                                  
                                      ),
                                  
                                      //Row With search
                                      Padding(
                                  
                                        padding: const EdgeInsets.only(top: 12.0, left: 8, bottom: 2),
                                  
                                        child: Row(
                                  
                                          mainAxisAlignment: MainAxisAlignment.start,
                                  
                                          mainAxisSize: MainAxisSize.min,
                                  
                                          children: [
                                  
                                            Expanded(
                                  
                        child: TextField(
                                  
                          controller: _searchTextController,
                                  
                          onChanged: (val) {
                                  
                            if (val.isNotEmpty) {
                                  
                              setState(() {});
                                  
                            } else {
                                  
                              setState(() {});
                                  
                            }
                                  
                          },
                                  
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              isDense: true,
                              prefixIcon: Icon(Icons.search_outlined),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.all(Radius.circular(7))),
                                  
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.all(Radius.circular(7))),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.all(Radius.circular(7))),
                              hintText: 'Search ...'),
                                  
                        ),
                                  
                                            ),
                                            const SizedBox(
                        width: 1.5,
                                            ),
                                  
                                            SizedBox(
                        height: 48,
                                  
                        child: Container(
                                  
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.white,
                              border: const Border(
                                top: BorderSide(color: Colors.grey, width: 1),
                                bottom: BorderSide(color: Colors.grey, width: 1),
                                left: BorderSide(color: Colors.grey, width: 1),
                                right: BorderSide(color: Colors.grey, width: 1),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  offset: const Offset(0, 3),
                                )
                              ]),
                                  
                          child: IconButton(
                                  
                            onPressed: () {},
                                  
                            icon: const Icon(
                                  
                              Icons.expand_less,
                                  
                              color: Colors.amber,
                                  
                            ),
                                  
                          ),
                                  
                        ),
                                  
                                            )
                                  
                                          ],
                                  
                                        ),
                                  
                                      ),
                                  
                                    Expanded(
                                  
                          child: ListView.builder(
                                  
                            itemCount: displayJobs.length,
                                  
                            itemBuilder: (_, index) {
                                  
                              return GestureDetector(
                                onLongPress: () async {
                                  userModule.currentUser.value.role == "admin" ?
                                   await _dismissDialog(snapshot.data![index]!) :
                                        ();
                                },
                                
                                child: Padding(
                                    
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                    
                                  child: ItemListTile(
                                    title: users[index]?.firstName ?? '',
                                    description: users[index]?.phoneNo ?? '',                                  
                                    subTitle: users[index]?.role ,
                                     
                                      onTap: () {
                                
                                                          Navigator.push(
                                
                                context,
                                
                                MaterialPageRoute(
                                
                                    builder: ((context) => isCustomer == true
                                
                                        ? AddCustomer(
                                
                                            customer: users[index],
                                
                                            isEditing: true,
                                
                                          )
                                
                                        : AddUserWidget(
                                
                                            user: users[index], isEditing: true))));
                                
                                                        },
                                  
                                  ),
                                    
                                ),
                              );
                                  
                            },
                                  
                          ),
                                  
                        )
                                  
                                      //List View
                                     
                                  
                                    ],
                                  
                                  ),
                      );
       
                     
                    } else {
          
                      return const Center(
          
                        child: CircularProgressIndicator(),
          
                      );
          
                    }
          
                  })
     
    );

  }

}

