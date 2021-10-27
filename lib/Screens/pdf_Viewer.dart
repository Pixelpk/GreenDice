import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
class PDFVIEWER extends StatelessWidget {
  PDFDocument pdfDocument ;
   PDFVIEWER({Key? key , required this.pdfDocument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  PDFViewer(document: pdfDocument,
      pickerButtonColor: Colors.green,
      ));

  }
}
