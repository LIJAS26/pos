//@dart=2.9
import 'dart:io';
import 'dart:typed_data';
import 'package:awafi_pos/main.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:universal_html/html.dart' as html;
import '../../Branches/branches.dart';
import '../../modals/Print/pdf_api.dart';
import '../ingredient_report.dart';
import 'categoryReportModel.dart';
import 'ingredinetReportModel.dart';
var image;



var format = NumberFormat.simpleCurrency(locale: 'en_in');

class IncredinetPdfPage {

  static Future<File> generate(IncredientReportData invoice) async {
    double gdtotal=0;
    // print(invoice.To);
    // print(invoice.From);
    final pdf = Document();
    image = await imageFromAssetBundle(imagelogo);

    pdf.addPage(MultiPage(
        build: (context) => [

          pw.Container(
            height: 100,
            width: 100,
            child:pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Image(image,width: 90,height: 90,fit: pw.BoxFit.contain),
                ]
            ),
          ),
          pw.Text('Incredient Report',
              style: pw.TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold)),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [

                pw.Container(
                  width: 250,
                  child:  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [

                        pw.SizedBox(height: 20),
                        pw.Row(
                            children: [
                              pw.Container(width: 70,child: pw.Text('Shop Name',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                              pw.Container(width: 170,child: pw.Text(': Point Plus',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),

                            ]
                        ),
                        pw.SizedBox(height: 5),
                        pw.Row(
                            children: [
                              pw.Container(width: 70,child: pw.Text('Vat Number',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                              pw.Container(width: 170,child: pw.Text(': $vatNumber',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                            ]
                        ),
                        // pw.SizedBox(height: 5),
                        // pw.Row(
                        //     children: [
                        //       pw.Container(width: 70,child: pw.Text('Starting Date',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                        //       pw.Container(width: 170,child: pw.Text(': ${DateFormat("yyyy-MM-dd   hh:mm  aaa").format(invoice.From)}',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                        //     ]
                        // ),
                        // pw.SizedBox(height: 5),
                        // pw.Row(
                        //     children: [
                        //       pw.Container(width: 70,child: pw.Text('Ending Date',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                        //       pw.Container(width: 170,child: pw.Text(': ${DateFormat("yyyy-MM-dd   hh:mm  aaa").format(invoice.To)}',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                        //     ]
                        // ),

                      ]
                  ),
                ),


              ]
          ),

          pw.SizedBox(height: 30),


          pw.Container(
            child:  pw.Table.fromTextArray(
                context: context,
                headers: [
                  'Incredient Name',
                  'Remaining Quantity'
                ],
                data:
                List.generate(invoice.ing.length??0, (index) {
                  final item =invoice.ing[index]??0;
                  print("${item}*************************");
                  // double total=double.tryParse(item["price"].toString())??0*double.tryParse(item["quantity"].toString())??0;
                  double total=double.tryParse(item["quantity"].toString())??0;
                  gdtotal+=total??0;
                  print(item.toString()+'                    $index');
                  return [
                    item['ingredient']??"",
                   item["quantity"]??0



                  ];
                })

            ),
          ),


          //
          // pw.Row(
          //     mainAxisAlignment: pw.MainAxisAlignment.end,
          //     children: [
          //
          //       pw.Container(width: 120,child: pw.Text('Grand Total : $gdtotal',style: pw.TextStyle(fontSize: 11,)),)
          //     ]
          // ),

          pw.Container(
              height: 40
          ),

          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('seal',style: pw.TextStyle(fontSize: 11,)),
                pw.Container(width: 120,child: pw.Text('Official Signature',style: pw.TextStyle(fontSize: 11,)),)
              ]
          ),
          pw.SizedBox(height: 30),

        ]
    ),

//END
//         pw.Container(
//           height: 50,
//           width: 700,
//
//         ),
//       ],
      // )
    );



    //web
    // final bytes = pdf.save();
    // final blob = html.Blob([bytes], 'application/pdf');
    // final url = html.Url.createObjectUrlFromBlob(
    //     await generate());
    // final anchor =
    // html.document.createElement('a') as html.AnchorElement
    //   ..href = url
    //   ..style.display = 'none'
    //   ..download = 'some_name.pdf';
    // html.document.body.children.add(anchor);
    // anchor.click();
    // html.document.body.children.remove(anchor);
    // html.Url.revokeObjectUrl(url);

    // await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
    // print('bbbbbbbbbbbbbbbbbbbbbbbb');

    //android
    return PdfApi.saveDocument(name: 'Ingredient Wise Report.pdf', pdf: pdf);
    // return PdfApi.saveDocument(name: '${invoice.from.toDate().toString().substring(0,10)} - ${invoice.from.toDate().toString().substring(0,10)}.pdf', pdf: pdf);
  }


}