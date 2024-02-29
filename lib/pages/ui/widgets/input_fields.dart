// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:truck_manager/pages/color.dart';

Widget InputField(String label, TextEditingController controller, bool error, {
  Function(String val)? onChanged, bool isNumbers = false, bool invalid = false, bool isHidden = false, int maxLines = 1,
  TextInputType? keyboardType
}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          // label
          SizedBox(width: 80, child: Text('$label:')),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(width: .8, color: error ? Colors.redAccent : Colors.grey)
              ),
              child: TextField(
                keyboardType: keyboardType,
                controller: controller,
                onChanged: onChanged,
                obscureText: isHidden,
                maxLines: maxLines,
                inputFormatters: [
                  if(isNumbers) FilteringTextInputFormatter.allow(RegExp(r'\d+\.?\d*'))
                ],
                decoration: InputDecoration(
                  errorText: error ? "\t\t*required!" : invalid ? "\t\t*$label invalid!" : null,
                  border: const UnderlineInputBorder(borderSide: BorderSide.none)),
              ),
            )
          ),
        ],
      ),
    );
  }
  Widget InputField2(String label, TextEditingController controller, bool error,bool obsecured, {
  Function(String val)? onChanged,
  void Function()? toggleObsecure,
   bool isNumbers = false, 
   bool  hasLabel = false, 
   bool invalid = false, 
   bool isObsecured = false, 
   bool isHidden = false, int maxLines = 1,
  TextInputType? keyboardType
}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          // label
         // SizedBox(width: 80, child: Text('$label:')),
          Expanded(
            child: TextField(
              keyboardType: keyboardType,
              controller: controller,
              onChanged: onChanged,
              obscureText: obsecured ? true : false,
              maxLines: maxLines,
              
              inputFormatters: [
                if(isNumbers) FilteringTextInputFormatter.allow(RegExp(r'\d+\.?\d*'))
              ],
              decoration: InputDecoration(
               
                  suffixIcon:  isObsecured == true ? 
                   GestureDetector(

                  onTap: toggleObsecure,

                  child: Icon(

                    obsecured

                        ? Icons.visibility_rounded

                        : Icons.visibility_off_rounded,

                  )) : Text(""),

              hintText:  label,
              labelText:  label  ,

              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12.5),

              isDense: true,
                errorText: error ? "\t\t*required!" : invalid ? "\t\t*$label invalid!" : null,
                border: OutlineInputBorder(
            
                borderRadius: BorderRadius.circular(8),
            
                borderSide:
            
                    BorderSide(color: Colors.grey.shade400, width: .9)),
            
            enabledBorder: OutlineInputBorder(
            
                borderRadius: BorderRadius.circular(8),
            
                borderSide:
            
                    BorderSide(color: Colors.grey.shade400, width: .4)),
            
            focusedBorder: OutlineInputBorder(
            
                borderRadius: BorderRadius.circular(8),
            
                borderSide: BorderSide(color: HexColor("#00877D"), width: 1)),
            
              ),  
            )
          ),
        ],
      ),
    );
  }