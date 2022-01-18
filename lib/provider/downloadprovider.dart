
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class Download with ChangeNotifier, DiagnosticableTreeMixin {
  int segmentValue = 0;
  int? indexi = -1;
  downloadFile(List bookinfo, int index,Map<Permission, PermissionStatus> statuses) async {
    print("$index");
    indexi = index;
   

    if (statuses[Permission.storage]!.isGranted) {
      var dir = await DownloadsPathProvider.downloadsDirectory;
      if (dir != null) {
        String savePath = '${dir.path}/${bookinfo[0]}';
        print(savePath);
        //output:  /storage/emulated/0/Download/banner.png

        try {
          var res = await Dio().post(
            "https://api.telegram.org/bot2008898965:AAE3SADGW0yk7PeCcHyp8kexIihPfKSdDw4/getFile",
            data: {"file_id": "${bookinfo[2]}"},
          );
          await Dio().download(
              "https://api.telegram.org/file/bot2008898965:AAE3SADGW0yk7PeCcHyp8kexIihPfKSdDw4/${res.data['result']['file_path']}",
              savePath, onReceiveProgress: (received, total) {
            if (total != -1) {
              segmentValue = int.parse((received / total * 100).toStringAsFixed(0));
              print((received / total * 100).toStringAsFixed(0) + "%");
              //you can build progressbar feature too
              notifyListeners();
            }
          });

          print("File is saved to download folder.");
        } on DioError catch (e) {
          print(e.message);
        }
      }
    } else {
      print("No permission to read and write.");
    }
    notifyListeners();
  }
}
