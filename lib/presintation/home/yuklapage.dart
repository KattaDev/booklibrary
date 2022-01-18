import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:ilmtop/provider/openprovider.dart';
import 'package:ilmtop/provider/searchprovider.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:ai_progress/ai_progress.dart';
import 'package:provider/src/provider.dart';

class Yuklashuchun extends StatefulWidget {
  String javList;
  Yuklashuchun(
    this.javList,
  );

  @override
  _YuklashuchunState createState() => _YuklashuchunState();
}

class _YuklashuchunState extends State<Yuklashuchun> {
  // final sampleUrl = 'http://www.africau.edu/images/default/sample.pdf';

  @override
  void initState() {
    
    super.initState();
  }
  // @override
  // void dispose() async {
  //   super.dispose();
  //   await context.read<Open>().deletefile;
  // }

  // int? pages = 0;
  // int? currentPage = 0;
  // bool isReady = false;
  // String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Plugin example app'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
           
            openFile()
          ],
        ),
      ),
    );
  }

  Widget openFile() {
    if ((widget.javList!= null)) {
      return Container(
          margin: EdgeInsets.all(2),
          height: MediaQuery.of(context).size.height * 0.8,
          child: yabn());
    } else {
      return Center(
          //   child: Column(
          //     children: [
          //        Stack(
          //         alignment: Alignment.center,
          //         children: <Widget>[
          //           // Container(
          //           //   width: 150,
          //           //   height: 150,
          //           //   padding: EdgeInsets.all(5),
          //           //   child: CircularProgressIndicator(
          //           //     value: context.watch<Open>().progress / 10,
          //           //     strokeWidth: 10.0,
          //           //     valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          //           //   ),
          //           // ),
          //           // Text("${context.watch<Open>().progress / 10 * 100}%"),
          //         ],
          //       ),
          //      ],
          //   ),
          );
    }
  }

  yabn() {
    return SfPdfViewer.network(widget.javList);
  }
}
