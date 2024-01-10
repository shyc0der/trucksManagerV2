// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:get/get.dart';
import 'package:truck_manager/pages/models/tenantsModel.dart';



class TenantModules extends GetxController {
  final TenantsModel tenantsModel = TenantsModel();
  RxList<TenantsModel> tenants = <TenantsModel>[].obs;

  TenantsModel? getTenantById(String? tenantId) {
    final _tenants = tenants.where((tenant) => tenant.id == tenantId).toList();
    if (_tenants.isNotEmpty) {
      return _tenants.first;
    }
    else {
      return null;
    }
  }

  //list of jobs per vehicle
  Stream<List<TenantsModel>> fetchAllTenants() {
    //fetch job and then get vehicleid
     
    var tenants = tenantsModel.fetchStreamsData().
    map<List<TenantsModel>>((snapshot) {
     var tnts = snapshot.docs.map<TenantsModel>((doc){
           return TenantsModel.fromMap({...(doc.data() as Map),'id' : doc.id});
     }).toList();
     return tnts;
    });

     return tenants;
  }

}
//list of jobs per expenses
//get amount