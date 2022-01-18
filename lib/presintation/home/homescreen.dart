import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:ilmtop/const/size_config.dart';
import 'package:ilmtop/presintation/addfile/addfile.dart';
import 'package:ilmtop/presintation/booklist/downloadpage.dart';
import 'package:ilmtop/presintation/home/homepage.dart';
import 'package:ilmtop/presintation/search/searchpage.dart';
import 'package:ilmtop/presintation/view/view.dart';
import 'package:ilmtop/provider/data.dart';

import 'package:path_provider/path_provider.dart';
// import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var currentIndex = 0;
  List<Widget> pageList = [GridView2(), SearchPage(),FilePickerDemo(), DownloadsPage()];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
     
      body: pageList[currentIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(top: 2,bottom: screenWidth*0.05,right:screenWidth*0.05,left: screenWidth*0.05 ),
        height: screenWidth * .14,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * .024),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
             
              setState(() {
                currentIndex = index;
                HapticFeedback.lightImpact();
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                SizedBox(
                  width: screenWidth * .2125,
                  child: Center(
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      height: index == currentIndex ? screenWidth * .12 : 0,
                      width: index == currentIndex ? screenWidth * .2125 : 0,
                      decoration: BoxDecoration(
                        color: index == currentIndex
                            ? Colors.blueAccent.withOpacity(.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: screenWidth * .2125,
                  alignment: Alignment.center,
                  child: Icon(
                    listOfIcons[index],
                    size: screenWidth * .076,
                    color: index == currentIndex
                        ? Colors.blueAccent
                        : Colors.black26,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.search_rounded,
    Icons.add_rounded,
    Icons.download_rounded,
  ];
}
