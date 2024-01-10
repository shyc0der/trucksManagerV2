import 'package:flutter/material.dart';
import 'package:truck_manager/pages/ui/widgets/order_details_widget.dart';


class JobListTile extends StatelessWidget {
  const JobListTile(
      {required this.title,
      required this.orderNo,
      required this.dateTime,
      required this.amount,
      this.onTap,
      this.onDoubleTap,
      required this.jobState,
      super.key});
  final String title;
  final String orderNo;
  final DateTime dateTime;
  final String amount;
  final OrderWidgateState jobState;
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
        onTap: onTap,
        onLongPress: onDoubleTap,
        leading: Container(
          width: 6,
          color: jobState.color,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Text(orderNo),
          ],
        ),
        subtitle: Text(dateTime.toString().substring(0, 16)),
        trailing:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text('Ksh. $amount'),
          Text(
            jobState.value,
            style: TextStyle(
                color: jobState.color,
                fontWeight: FontWeight.bold,
                fontSize: 14.5),
          )
        ]),
      ),
    );
  }
}
