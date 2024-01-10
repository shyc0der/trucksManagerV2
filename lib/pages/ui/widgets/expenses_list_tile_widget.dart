import 'package:flutter/material.dart';
import 'package:truck_manager/pages/ui/widgets/order_details_widget.dart';

class ExpensesListTile extends StatelessWidget {
  const ExpensesListTile({required this.title, required this.driverName,required this.truckNumber, required this.dateTime, required this.amount, 
  this.onTap, 
  this.onDoubleTap, 
  required this.expenseState, super.key});
  final String title;
  final String driverName;
  final String truckNumber;
  final DateTime dateTime;
  final String amount;
  final OrderWidgateState expenseState;
  final void Function()? onTap;
  final void Function()? onDoubleTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(2),
      color: Colors.white,
      border: const Border(bottom: BorderSide(width: 1,color:  Color.fromARGB(95, 183, 181, 181))),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 0,
          blurRadius: 0,
          offset: const Offset(0, 3), 
        )
      ]          
         
    ),
       
      child: ListTile(
        contentPadding: const EdgeInsets.only(top:4.0,bottom: 4.0 ,left: 6.0),
        isThreeLine: true,
        onTap: onTap,
        onLongPress: onDoubleTap,
        leading: Container(
          width: 6,
          color: expenseState.color,
        ),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Text(truckNumber),
            Text(driverName),            
            Text(dateTime.toString().substring(0, 16))
          ],
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 7.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
            Text(expenseState.value,style: TextStyle(color: expenseState.color,fontWeight: FontWeight.bold,fontSize: 14.5), ),
            const SizedBox(height:15),
            Text('Ksh. $amount'),
          ]),
        ),
      ),
    );
  }
}