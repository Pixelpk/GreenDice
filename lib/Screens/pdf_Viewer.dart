import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/material.dart';
class PDFOPENER extends StatelessWidget {

String url ;
PDFOPENER({required this.url});
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
