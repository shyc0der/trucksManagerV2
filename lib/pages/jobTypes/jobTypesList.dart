// ignore_for_file: use_build_context_synchronously, use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truck_manager/components.dart';
import 'package:truck_manager/pages/models/jobType.dart';
import 'package:truck_manager/pages/modules/jobTypesModules.dart';
import 'package:truck_manager/pages/modules/userModules.dart';
import 'package:truck_manager/pages/ui/widgets/dismiss_widget.dart';
import 'package:truck_manager/pages/ui/widgets/input_fields.dart';

class JobTypesPage extends StatefulWidget {
  const JobTypesPage({Key? key}) : super(key: key);

  @override
  _JobTypesPageState createState() => _JobTypesPageState();
}

//Displays Jobs
class _JobTypesPageState extends State<JobTypesPage> {
  final JobTypeModule _jobTypeModule = JobTypeModule();
  final UserModule userModule = Get.find<UserModule>();



  Future<bool> _dismissDialog(JobType job) async {
    bool? delete = await dismissWidget('${job.name}');
    bool shouldDelete = delete == true;
   
    

    var ifExists = await _jobTypeModule.checkIfJobTypeExists(
        job.name ?? '', userModule.currentUser.value.tenantId!);

    if (ifExists == true) {
      shouldDelete = false;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text("Job Type Can Not Be Deleted Since Its Already Used!"),
      ));
    }

    if (shouldDelete) {
      //if Job Type does exists one cannnot delete an job Type that is already tied to an job

      await _jobTypeModule.deleteJobTpe(job.id ?? '');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Job Type Deleted!"),
      ));

      // delete from server
    }

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
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const Dialog(
                      child: AddJobTypeWidget(),
                    );
                  });
            },
            icon: const Icon(Icons.add)),
      ),
      body: StreamBuilder<List<JobType?>>(
          stream: _jobTypeModule
              .fetchJobType(userModule.currentUser.value.tenantId!),
          builder: (context, snapshot) {
            var jobTypes = snapshot.data ?? [];
            return Column(
              children: [
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
                            "Job Types",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                          ),
                                  
                          Text(
                            jobTypes.length.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                                  
                          ),
                                  
                        ],
                                  
                                            ),
                                  
                                          ),
                                  
                                        ),
                                  
                                      ),
                Expanded(
                  child: ListView.builder(
                    itemCount: (snapshot.data ?? []).length,
                    itemBuilder: (BuildContext context, int index) {
                      var jobType = snapshot.data![index]!;
                      return GestureDetector(
                        onDoubleTap: () async {
                          // dismissDialog
                           _dismissDialog(jobType);
                        },
                        key: ValueKey('$index-${jobType.name}'),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                            child: ItemListTile(
                                      title:  jobType.name ?? '',
                                      description: jobType.name ?? '',
                                     
                                    ),
                            
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
    );
  }
}

//ADD JOBS
class AddJobTypeWidget extends StatefulWidget {
  const AddJobTypeWidget({Key? key}) : super(key: key);

  @override
  _AddJobTypeWidgetState createState() => _AddJobTypeWidgetState();
}

class _AddJobTypeWidgetState extends State<AddJobTypeWidget> {
  JobTypeModule jobModule = JobTypeModule();
  late final TextEditingController _addJobTypeController;
  final UserModule userModule = Get.find<UserModule>();

  bool _addJobError = false;

  @override
  void initState() {
    super.initState();
    _addJobTypeController = TextEditingController();
  }

  @override
  void dispose() {
    _addJobTypeController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Add Job Type',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
          ),
          const SizedBox(
            height: 15,
          ),
          InputField(
              "Job Type", _addJobTypeController, _addJobError,
              onChanged: (String val) {
            if (val.isNotEmpty) {
              setState(() {
                _addJobError = false;
              });
            }
          }),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // cancel
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('cancel')),
              ElevatedButton(
                  onPressed: () {
                    // check if input is empty
                    if (_addJobTypeController.text.isEmpty) {
                      setState(() {
                        _addJobError = true;
                      });
                    } else {
                      // proceed saving
                      jobModule.addJobType(JobType(
                        tenantId: userModule.currentUser.value.tenantId!,
                        name: _addJobTypeController.text,
                      ));
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Add'))
            ],
          )
        ],
      ),
    );
  }
}
