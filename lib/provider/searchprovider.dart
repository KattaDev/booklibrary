import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:ilmtop/provider/data.dart';

class Search with ChangeNotifier, DiagnosticableTreeMixin {
  String? filepath;
  List<List<String>> javoblist = [];


  double progress = 0;
  File? deleteFile;

  void increment(String v) {
    javoblist = [];
    for (List<String> item in data) {
      if (item[0].toLowerCase().contains(v.toLowerCase())) {
        if (javoblist.length > 100) {
          break;
        }
        javoblist.add(item);
      }
    }

    notifyListeners();
  }


}
