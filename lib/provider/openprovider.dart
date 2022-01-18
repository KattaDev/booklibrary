import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Open with ChangeNotifier, DiagnosticableTreeMixin {
  // String? uripath;
  

  downloadAndSavePdf(List bookdata) async {
    // final directory = await getApplicationDocumentsDirectory();
    // final externalDocumentsDirectory = getExternalStorageDirectory();
    // final file = File('${directory.path}/${bookdata[0]}');
    // print("${externalDocumentsDirectory.toString()}");

    var res = await Dio().post(
      "https://api.telegram.org/bot2008898965:AAE3SADGW0yk7PeCcHyp8kexIihPfKSdDw4/getFile",
      data: {"file_id": "${bookdata[2]}"},
    );
    print("${res.data['result']['file_path']}");
    String uril =
        "https://api.telegram.org/file/bot2008898965:AAE3SADGW0yk7PeCcHyp8kexIihPfKSdDw4/${res.data['result']['file_path']}";
    return uril;
    // var request = new http.Request("GET", Uri.parse(uril));

    // http.StreamedResponse response = await http.Client().send(request);
    // final contentLength = response.contentLength!;
    
    // List<int> bytes = [];
    // await response.stream.listen(
    //   (List<int> newBytes) {
    //     bytes.addAll(newBytes);
    //     final downloadedLength = bytes.length;
        // progress = downloadedLength / contentLength;
    //     notifyListeners();
    //   },
    //   onDone: () async {
    //     notifyListeners();
    //   },
    //   onError: (e) {
    //     print(e);
    //   },
    //   cancelOnError: true,
    // );
  }
}
