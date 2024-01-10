// ignore_for_file: file_names

import 'package:truck_manager/pages/models/model.dart';

class JobType extends Model{
  JobType({
   this.id,this.name,this.tenantId
  }):super('jobTypes');
  String? id;
  String? name;
  String? tenantId;
  Map<String,dynamic> asMap()
{
  return {
    if(id != null) 'id': id,
    'name': name,
    'tenantId': tenantId,
  };
}
//how to know methods or constructors that have a return type
JobType.fromMap(Map map):super('jobTypes'){
  
    id=map['id'];
    name=map['name'];
    tenantId=map['tenantId'];
    
  
}
}
