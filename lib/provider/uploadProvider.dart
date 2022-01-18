import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class Upload with ChangeNotifier, DiagnosticableTreeMixin {
  bool? stop;
   List<String> pdfpath = [];

  getPath() async {
    pdfpath = [];
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      pdfpath = [];
      pdfpath.add("${result.names.last}");
      print("${pdfpath}");
      File file = await File(result.files.single.path!);
      pdfpath.add(file.path);
      print("${pdfpath}");
      stop = false;notifyListeners();
    } else {}
    notifyListeners();
  }
}
