import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ilmtop/provider/uploadProvider.dart';
import 'package:provider/src/provider.dart';

class FilePickerDemo extends StatefulWidget {
  @override
  _FilePickerDemoState createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  List<String> path=[];

  var captionController;

  
  
@override
  void initState() {
    context.read<Upload>().getPath();

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _scaffoldMessengerKey,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text(''),
        ),
        body: Column(
          children: [
            Center(
              child: progress(context),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                   path = await context.watch<Upload>().pdfpath;

                  if (path.isNotEmpty) {
                    print("________________________");
                    MultipartFile fromdat = await MultipartFile.fromFile(
                      "${path[1]}",
                      // "//data/user/0/com.example.ilmtop/cache/file_picker/instruction-uz.pdf",
                      // "//com.android.providers.downloads.documents/document/raw%3A%2Fstorage%2Femulated%2F0%2FDownload%2FAruz%20vazniga%20oid%20baytlar%20tahlili.pdf",
                      //  "/storage/emulated/0/Download/Aruz vazniga oid baytlar tahlili.pdf",
                      filename: path[0],
                    );
                    var res = await Dio().post(
                      "https://api.telegram.org/bot5086197624:AAGK6fpCiE-YtKOkqoVqBp_xewujzrww35Q/sendDocument",
                      data: FormData.fromMap({
                        "chat_id": -1001778111155,
                        "document": fromdat,
                      }),
                    );
                    if (res.statusCode == 200) {
                      context.watch<Upload>().stop = true;
                    }
                  }
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.folder,
                      size: 30,
                    ),
                    Text("Kitob Yuborish"),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(
                  MediaQuery.of(context).size.width * 0.5,
                  MediaQuery.of(context).size.width * 0.1,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox progress(BuildContext context) {
    if (context.watch<Upload>().stop != null) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: context.watch<Upload>().stop!
            ? CircularProgressIndicator(
                strokeWidth: 15,
              )
            : Icon(
                Icons.check,
                size: 40,
              ),
      );
    } else {

      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Text(
          "Kitoblar yuboring.\nIlm Ulashing",
          style: TextStyle(color: Colors.indigo, fontSize: 40),
        ),
      );
    }
  }

  showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () { },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Row(children: [Image.asset("assets/images/file.jpg"), SizedBox(width: MediaQuery.of(context).size.height*0.1,),Text("${path[0]}")],),
    content:  Container(
            height: MediaQuery.of(context).size.width / 8,
            width: MediaQuery.of(context).size.width / 1.22,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.height * 0.03,
            ),
            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 30),
            decoration: BoxDecoration(
              color: Color(0xff212428),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextFormField(
             
              controller: captionController,
              style: textfieldstyle(),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search_outlined,
                  color: Colors.white.withOpacity(.7),
                ),
                border: InputBorder.none,
                hintMaxLines: 1,
                hintText: 'Izlash...',
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.cyan,
                ),
              ),
            ),
          ),
         
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
  TextStyle textfieldstyle() => TextStyle(color: Colors.white.withOpacity(.9));

}
