import 'package:truck_manager/pages/models/model.dart';
import 'package:truck_manager/pages/ui/widgets/user_widget.dart';

class UserModel extends Model {
  UserModel(

     {
      this.id,
      this.firstName,
      this.address,
      this.receiptPath,
      this.lastName,
      this.phoneNo,
      this.idNumber,
      this.tenantId,
      this.email,
      UserWidgetType ? userRole,
      this.onLongPress,
       bool? isActive ,
       bool?  isDeleted ,
      this.onTap})
      : super('users'){
        this.isActive=isActive ?? true;
        this.isDeleted=isDeleted ?? false;   
        role = userRole?.lable ?? 'normal';    
        }

  UserWidgetType get userRole => userRoleFromString(role ?? ''); 

  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNo;
  String? idNumber;
  String? tenantId;
  String? role;
  String? address;
  String? receiptPath;
  void Function()? onTap;
  void Function()? onLongPress;

  bool isActive = true;
  bool isDeleted = false;

  UserModel.fromMap(Map map) : super('users') {
    id = map['id'];
    firstName = map['firstName'];
    lastName = map['lastName'];
    address = map['address'];
    email = map['email'];
    phoneNo = map['phoneNo'];
    tenantId = map['tenantId'];
    idNumber = map['idNumber'];
    receiptPath = map['receiptPath'];
    role = map['role'];
    isActive = map['isActive'] ?? true;
    isDeleted = map['isDeleted'] ?? false;
    onTap = map['onTap'];
    onLongPress = map['onLongPress'];
  }

  Map<String, dynamic> asMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'tenantId': tenantId,
      'receiptPath': receiptPath,
      'phoneNo': phoneNo,
      'email': email,
      'role': role,
      'isActive': isActive,
      'isDeleted': isDeleted
    };
  }
}

class Test {
  String? email;
  String? name;
  String? tenant;
}