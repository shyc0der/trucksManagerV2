import 'package:truck_manager/pages/models/jobType.dart';
import 'package:truck_manager/pages/modules/order_modules.dart';


class JobTypeModule {
  final JobType _jobType = JobType();
  final OrderModules orderModules= OrderModules();
  Future<bool> addJobType(JobType jobType) async {
    await _jobType.saveOnline(jobType.asMap());
    return true;
  }

  Stream<List<JobType>> fetchJobType(String tenantId) {
    return _jobType
        .fetchStreamsDataWhere(
      'tenantId',
      isEqualTo: tenantId,
    )
        .map((snapshots) {
      return snapshots.docs
          .map<JobType>((doc) =>
              JobType.fromMap({'id': doc.id, ...doc.data() as Map}))
          .toList();
    });
  }

  Future<List<String>> fetchJobTypesAsString(String tenantId) async {
    return (await _jobType.fetchWhereData('tenantId', isEqualTo: tenantId))
        .map((snapshot) => snapshot.data()['name'].toString())
        .toList();
  }

  Future<void> deleteJobTpe(String id) async {
    await _jobType.deleteOnline(id);
  }

  Future<bool> checkIfJobTypeExists(String name, String tenantId) async {
    bool test;
    var jobsType =
        await orderModules.fetchAllJobsByTitle(name, tenantId);

    if (jobsType == [] || jobsType.isEmpty) {
      test = false;
    } else {
      test = true;
    }

    return test;
  }
}
