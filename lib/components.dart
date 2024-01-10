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
  onPressed: widget.onPressed,
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
      this.onTap,
      this.onDoubleTap,
      this.subTitle,
      super.key, required this.description});
  final String title;
  final String description;
  final String? subTitle;
  final void Function()? onTap;
  final void Function()? onDoubleTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
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
      title: Text(title),
      
      subtitle:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(description,style: const TextStyle(fontSize: 12)),
              Text(subTitle ?? '',style: const TextStyle(fontSize: 12)),
            ],
          ),
        
      
      trailing:
            
          const Icon(Icons.arrow_forward_ios_outlined,size: 12.0, ),
         
        
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

      