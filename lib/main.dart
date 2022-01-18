import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:ilmtop/provider/downloadprovider.dart';
import 'package:ilmtop/provider/openprovider.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';

import 'presintation/splash/splash.dart';
import 'provider/searchprovider.dart';
import 'provider/uploadProvider.dart';

void main() async {
  await GetStorage.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Search()),
        ChangeNotifierProvider(create: (_) => Open()),
        ChangeNotifierProvider(create: (_) => Download()),
        ChangeNotifierProvider(create: (_) => Upload()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor:  Colors.grey.shade800,
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.grey.shade800,
              titleTextStyle: TextStyle(color: Colors.cyanAccent))),
      home: SplashPage(),
    );
  }
}
