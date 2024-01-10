// ignore_for_file: file_names

import 'package:truck_manager/pages/models/model.dart';

class ExpenseType extends Model{
  ExpenseType({
   this.id,this.name,this.tenantId
  }):super('expenseType');
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
ExpenseType.fromMap(Map map):super('expenseType'){
  
    id=map['id'];
    name=map['name'];
    tenantId=map['tenantId'];
    
  
}
}
