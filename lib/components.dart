import 'package:flutter/material.dart';
import 'package:truck_manager/pages/color.dart';

class KnackBar extends StatefulWidget{
  const KnackBar({super.key, required this.title, this.colors, required this.size, this.onPressed});
  final String title ;
  final Color ? colors ;
  final  double size ;
  final void Function()? onPressed ;
  @override
  State<StatefulWidget> createState() => KnackBarState();

}
class KnackBarState extends State<KnackBar>{
 
  @override
  Widget build(BuildContext context) {
 return Container(
  padding: const EdgeInsets.only(top: 10, left: 6),
  margin: const EdgeInsets.symmetric(vertical: 2),
 child: ElevatedButton(
  onPressed: (){},
  child: Text(widget.title,
  style:  TextStyle(fontSize: widget.size,
  fontWeight: FontWeight.bold ,color: widget.colors),
  ) ,
 ),
 );
  }
}

class ItemListTile extends StatelessWidget {
  const ItemListTile(
      {required this.title,
      required this.orderNo,
      required this.dateTime,
      required this.amount,
      this.onTap,
      this.onDoubleTap,
      Key? key})
      : super(key: key);
  final String title;
  final String orderNo;
  final DateTime dateTime;
  final String amount;
  final void Function()? onTap;
  final void Function()? onDoubleTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
        child: ListTile(
        onTap: onTap,
        onLongPress: onDoubleTap,
        title: Text(title),
        
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(orderNo,style: const  TextStyle(fontSize: 12),),
            Text(dateTime.toString().substring(0, 16),style: const TextStyle(fontSize: 11))
          ],
        ),
        trailing:
      
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
              children: [  
                 
           Container(
            
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: Colors.orangeAccent,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 3)
                )
              ]
    
            ),
            width: 60,
            height: 14,
             child: const Padding(
               padding: EdgeInsets.only(left: 13.0),
               child:  Text(
                 "Pending",style: TextStyle(fontSize: 10,
                color: Colors.white, 
                 )),
             ),
           ),
           
      Text(""),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
           
            Text('KES. $amount', style: const TextStyle(fontSize: 11)),
            const SizedBox(width: 4,),
            const Icon(Icons.arrow_forward_ios_outlined,size: 12.0, ),
           
          ],
        )
          
        ]),
      ),
    );
  }
}
class AppDropdownInput<T> extends StatelessWidget {
  final String hintText;
  final List<T> options;
  final T? value; // Changed to nullable
  final String Function(T) getLabel;
  final void Function(T?) onChanged;

  const AppDropdownInput({
    super.key,
    required this.hintText,
    required this.options,
    required this.getLabel,
    this.value, // Removed the required keyword
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      builder: (FormFieldState<T> state) {
        return InputDecorator(
          decoration: InputDecoration(
            fillColor: Colors.white,
            hoverColor: Colors.white,
            focusColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 15.0),
            hintText: hintText,
            border:
                     OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade400, width: .9)
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade400, width: .4)
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:  BorderSide(color: HexColor("#00877D"), width: 1)
                ),
          
                
                   ),
          isEmpty: value == null || value == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value, // Nullable value is now accepted
              isDense: true,
              onChanged: onChanged,
              dropdownColor: Colors.white,
              focusColor: Colors.white,
              
              items: options.map((T value) {
                return DropdownMenuItem<T>(
                  value: value,
                  child: Text(getLabel(value)),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

      