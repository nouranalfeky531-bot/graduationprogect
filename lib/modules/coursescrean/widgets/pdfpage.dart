import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PdfPage extends StatefulWidget {

  final String url;
  final String title;

  const PdfPage({ required this.url, required this.title});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {

  String? localPath;

  Future loadPdf() async {

    var response = await http.get(Uri.parse(widget.url));

    var dir = await getTemporaryDirectory();

    File file = File("${dir.path}/temp.pdf");

    await file.writeAsBytes(response.bodyBytes);

    setState(() {
      localPath = file.path;
    });

  }

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text(widget.title)),

      body: localPath == null
          ? const Center(child: CircularProgressIndicator())
          : PDFView(filePath: localPath!),

    );

  }

}