import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Viewer Demo',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  Future<void> openPDF(BuildContext context) async {
    final ByteData bytes = await rootBundle.load('assets/pdfs/sample.pdf');
    final Uint8List pdfData = bytes.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/sample.pdf');
    await file.writeAsBytes(pdfData, flush: true);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFViewerPage(filePath: file.path),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PDF Viewer')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => openPDF(context),
          child: Text('Open Sample PDF'),
        ),
      ),
    );
  }
}

class PDFViewerPage extends StatelessWidget {
  final String filePath;

  const PDFViewerPage({required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sample PDF')),
      body: PDFView(
        filePath: filePath,
        autoSpacing: true,
        pageSnap: true,
        swipeHorizontal: false,
        fitEachPage: true,
      ),
    );
  }
}
