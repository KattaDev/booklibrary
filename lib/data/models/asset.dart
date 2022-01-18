
// import 'dart:io';

// import 'package:path/path.dart';
// import 'dart:typed_data';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqlite3/sqlite3.dart';

// opendatabase() async {
//   var databasesPath = await getApplicationDocumentsDirectory();
//   var path = join(databasesPath.path, "demo_asset_example.db");

// // Check if the database exists
//   var exists = await databasesPath.exists();

//   if (!exists) {
//     // Should happen only the first time you launch your application
//     print("Creating new copy from asset");

//     // Make sure the parent directory exists
//     try {
//       await Directory(dirname(path)).create(recursive: true);
//     } catch (_) {}

//     // Copy from asset
//     ByteData data = await rootBundle.load(join("assets", "example.db"));
//     List<int> bytes =
//         data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

//     // Write and flush the bytes written
//    await File(path).writeAsBytes(bytes, flush: true);
//   } else {
//     print("Opening existing database");
//   }
// // open the database
//   Database db = await opendatabase();
  
// }
