import 'package:truck_manager/pages/models/model.dart';

class TenantsModel extends Model {

  TenantsModel({
    this.id,
    this.name,
    this.tenantId,
    this.database,
    bool? active,
    bool? deleted,
  }) : super('tenants') {
    isActive = active ?? true;
    isDeleted = deleted ?? false;
  }
  String? id;
  String? name;
  String? tenantId;
  String? database;
  bool isActive = true;
  bool isDeleted = false;

  TenantsModel.fromMap(Map map) : super('tenants') {
    id = map['id'];
    name =map['Name'];
    tenantId= map['TenantId'];
    database= map['Database'];
    isActive = map['isActive'] ?? true;
    isDeleted = map['isDeleted'] ?? false;
  }

  Map<String, dynamic> asMap() {
    return {
      
      'isActive': isActive,
      'isDeleted': isDeleted,
      'Database': database,
      'Name': name,
      'TenantId': tenantId,
    };
  }

  @override
  bool operator ==(Object other) {
    if (other is TenantsModel) {
      return id == other.id && name == other.name && database == other.database;
    }
    return false;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ database.hashCode;


}