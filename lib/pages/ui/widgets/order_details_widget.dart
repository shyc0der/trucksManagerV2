// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:truck_manager/pages/color.dart';
import 'package:truck_manager/pages/ui/reports/invoice_quotation_module.dart';
import 'package:pdf_reports_generator/pdf_reports_generator.dart' as pw;
import 'package:truck_manager/pages/ui/widgets/item_card_widget.dart';
class OrderDetailWidget extends StatefulWidget{
   const OrderDetailWidget(
      {required this.title,
      required this.amount,
      required this.date,
      required this.orderState,
      required this.orderNo,
      required this.orderId,
      this.update,
      this.onCancel,
      this.onClose,
      this.goToJob,
      super.key});
       final String title;
  final String amount;
  final String orderNo;
  final String orderId;
  final String date;
  final OrderWidgateState orderState;
  final void Function()? onCancel;
  final void Function()? onClose;
  final void Function()? update;
  final void Function()? goToJob;
   @override
OrderDetailWidgetState createState() => OrderDetailWidgetState();
}

class OrderDetailWidgetState extends State<OrderDetailWidget> {
 
 

  @override
  Widget build(BuildContext context) {
    return 
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      const  SizedBox(height: 7,),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 9.0),
           child: Container(
            
            padding: const EdgeInsets.symmetric(horizontal: 9,vertical: 9),
            decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10),
                   color: Theme.of(context).colorScheme.background,
                   boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 90, 86, 86).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
                   ]),
             child: Column(
              children: [
                    ItemDetailWidget(title: "Type", text:  widget.title,),
                    ItemDetailWidget(title: "Status", text: widget.orderState.value,bgcolor: widget.orderState.color,),
                    ItemDetailWidget(title: "Number", text: "ORD-${widget.orderNo}"),      
                    ItemDetailWidget(title: "Time",text: widget.date,),
                    ItemDetailWidget(title: "Amount",text: widget.amount,),
              ],
             ),
           ),
         ),     
        
const SizedBox(height: 23,),
      
     Row(            
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          
            children: [
          
              // quotation           
          
              if (!(widget.orderState == OrderWidgateState.Declined ||
          
                  widget.orderState == OrderWidgateState.Rejected ||
          
                  widget.orderState == OrderWidgateState.Pending))
          
                ElevatedButton(
          
                  onPressed: () => Navigator.push(
          
                      context,
          
                      MaterialPageRoute(
          
                          builder: (context) => _pdfGenerator(
          
                                isQuotation: true,
          
                              ))),
          
                  child: const Text('Quotation'),
          
                ),
          
          
              // invoice
          
          
              if (widget.orderState == OrderWidgateState.Closed)
          
                ElevatedButton(
          
                  onPressed: () => Navigator.push(
          
                      context,
          
                      MaterialPageRoute(
          
                          builder: (context) => _pdfGenerator(
          
                                isInvoice: true,
          
                              ))),
          
                  child: const Text('Invoice'),
          
                ),
          
          
              if (widget.orderState == OrderWidgateState.Closed)
          
                ElevatedButton(
          
                  onPressed: () => Navigator.push(
          
                      context,
          
                      MaterialPageRoute(
          
                          builder: (context) =>
          
                              _pdfGenerator(isDelNote: true))),
          
                  child: const Text('Delivery Note'),
          
                ),
          
            ],
          
          ),
      Flexible( child: Container()),
      
        Padding(
          padding: const EdgeInsets.only(bottom:12.0,left: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (widget.orderState == OrderWidgateState.Pending ||
                  widget.orderState == OrderWidgateState.Open)
                SizedBox(
                  width: 125,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 233, 36, 36)),
                      onPressed: widget.onCancel,
                      child: const Text('Cancel',style:  TextStyle(color: Colors.white))),
                ),
              if (widget.orderState == OrderWidgateState.Pending ||
                  widget.orderState == OrderWidgateState.Open)
                SizedBox(
                  width: 125,
                  child: ElevatedButton(
                       style: ElevatedButton.styleFrom(backgroundColor: HexColor("#00877D")),
                      onPressed: widget.orderState == OrderWidgateState.Pending
                          ? widget.update
                          : widget.goToJob,
                      child: Text(widget.orderState == OrderWidgateState.Pending
                          ? 'Update'
                          : 'Go To Respective Job',style: const TextStyle(color: Colors.white),)),
                ),
              if (widget.orderState == OrderWidgateState.Closed || widget.orderState == OrderWidgateState.Approved)
               Expanded(
                 child: ElevatedButton(
                   style:
                                ElevatedButton.styleFrom(
                 
                  backgroundColor: HexColor("#00877D"),
                 
                  foregroundColor: Colors.white,
                 
                  shadowColor: HexColor("#00877D"),
                 
                  elevation: 3,
                 
                  shape: RoundedRectangleBorder(
                 
                      borderRadius: BorderRadius.circular(32)),
                 
                  minimumSize: const Size(700, 50)),
                 
                  onPressed: widget.goToJob,
                   child: const Text('Go To Respective Job',style:  TextStyle(color: Colors.white)
                   )),
               ),
                 const SizedBox(
                
              height: 20,
                
            ),
                
                
                
            ],
          ),
        ),
    
      
      
      ],
    );
 
  }
   Widget _pdfGenerator({bool? isInvoice, bool? isDelNote, bool? isQuotation}) {

    final _pdf = InvoiceQuotationModule.fromOrderId(

      widget.orderId,

      isDelNote,

      isInvoice,

      isQuotation,

    );


    return PdfPreview(

      canDebug: false,

      pageFormats: const {

        'A4': pw.PdfPageFormat.a4,

        'Letter': pw.PdfPageFormat.letter,

        'A3': pw.PdfPageFormat.a3,

        'A5': pw.PdfPageFormat.a5,

        'A6': pw.PdfPageFormat.a6,

      },

      build: (pageFormat) async {

        return (await _pdf.generatePdf(pageFormat: pageFormat)).save();

      },

    );

  }

}

enum OrderWidgateState { All,Pending, Open, Closed, Rejected, Approved,Declined }

extension OrderWidgateStateExt on OrderWidgateState {
  Color get color {
    switch (this) {
      case OrderWidgateState.Pending:
        return Colors.amber;
    case OrderWidgateState.All:
        return Colors.brown;
      case OrderWidgateState.Open:
        return Colors.blue;
      case OrderWidgateState.Approved:
        return Colors.green;
      case OrderWidgateState.Rejected:
        return Colors.red;
        case OrderWidgateState.Declined:
        return Colors.red;
      case OrderWidgateState.Closed:
        return const Color.fromARGB(255, 48, 48, 48);
      default:
        return Colors.grey;
    }
  }

  String get value {
    switch (this) {
      case OrderWidgateState.Open:
        return 'Open';
        case OrderWidgateState.All:
        return 'All';
      case OrderWidgateState.Closed:
        return 'Closed';
      case OrderWidgateState.Rejected:
        return 'Rejected';  
     case OrderWidgateState.Declined:
        return 'Declined';
      case OrderWidgateState.Approved:
        return 'Approved';
      default:
        return 'Pending';
    }
  }
}

OrderWidgateState orderWidgateState(String val) {
  switch (val) {
    case 'Open':
      return OrderWidgateState.Open;
    case 'All':
      return OrderWidgateState.All;
    case 'Rejected':
      return OrderWidgateState.Rejected;
  case 'Declined':
      return OrderWidgateState.Declined;
    case 'Closed':
      return OrderWidgateState.Closed;
    case 'Approved':
      return OrderWidgateState.Approved;

    default:
      return OrderWidgateState.Pending;
  }
}
