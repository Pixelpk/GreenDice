import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/material.dart';
class PdfViewer extends StatelessWidget {

String url ;
PdfViewer({required this.url});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SfPdfViewer.network(
            url),
      )
    );
  }
}
