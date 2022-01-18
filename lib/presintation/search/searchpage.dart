import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ilmtop/presintation/home/yuklapage.dart';
import 'package:ilmtop/provider/downloadprovider.dart';
import 'package:ilmtop/provider/openprovider.dart';
import 'package:ilmtop/provider/searchprovider.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            height: _width / 8,
            width: _width / 1.22,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.height * 0.03,
            ),
            padding: EdgeInsets.only(right: _width / 30),
            decoration: BoxDecoration(
              color: Color(0xff212428),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextFormField(
              onChanged: (v) {
                context.read<Search>().increment(v);
              },
              controller: searchController,
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
          Container(
            height: MediaQuery.of(context).size.height * 0.78,
            child: context.watch<Search>().javoblist.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text("Kitob nomi yoki\n muallifini kiriting",textAlign: TextAlign.center,style: TextStyle(color: Colors.redAccent,fontSize: 20),),
                      SizedBox(height: _height*0.1,),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/search.gif"))),
                      ),
                      Text(
                        "Natijalar yo'q",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Qayta urining",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal),
                      ),
                    ],
                  )
                : AnimationLimiter(
                    child: ListView.builder(
                      padding: EdgeInsets.all(_w / 30),
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: context.watch<Search>().javoblist.length,
                      itemBuilder: (BuildContext context, int index) {
                        List<List<String>> datam =
                            context.watch<Search>().javoblist;
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          delay: Duration(milliseconds: 100),
                          child: SlideAnimation(
                            duration: Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: FadeInAnimation(
                              curve: Curves.fastLinearToSlowEaseIn,
                              duration: Duration(milliseconds: 2500),
                              child: Container(
                                child: Row(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.all(
                                          _height * 0.01,
                                        ),
                                        height: _height * 0.06,
                                        child: Image.asset(typeFile(datam[index][0]))),
                                    SizedBox(
                                      width: _height * 0.01,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: _height * 0.02,
                                        ),
                                        Expanded(
                                          child: Text("${datam[index][0]}"),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              TextButton(
                                                onPressed: () async {
                                                  Map<Permission,
                                                          PermissionStatus>
                                                      statuses = await [
                                                    Permission.storage,
                                                    //add more permission to request here.
                                                  ].request();
                                                  await context
                                                      .read<Download>()
                                                      .downloadFile(
                                                          datam[index],
                                                          index,
                                                          statuses);

                                                  HapticFeedback.lightImpact();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: const Text(
                                                        'Fayl Yuklanmalarga saqlandi!'),
                                                    duration: const Duration(
                                                        seconds: 6),
                                                    action: SnackBarAction(
                                                      label: 'Ko\'rish!',
                                                      onPressed: () async {
                                                        if (datam[index][0]
                                                            .endsWith(".pdf")) {
                                                          String uri = await context
                                                              .read<Open>()
                                                              .downloadAndSavePdf(
                                                                  datam[index]);

                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      Yuklashuchun(
                                                                          uri)));
                                                        }
                                                      },
                                                    ),
                                                  ));
                                                },
                                                child: Text("Yuklash"),
                                              ),
                                              SizedBox(
                                                height: _height * 0.02,
                                                width: _w * 0.35,
                                                child: context
                                                            .watch<Download>()
                                                            .indexi ==
                                                        index
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          SizedBox(
                                                            width: _w * 0.2,
                                                            child:
                                                                LinearProgressIndicator(
                                                              value: context
                                                                      .watch<
                                                                          Download>()
                                                                      .segmentValue /
                                                                  100,
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                          Color>(
                                                                      Colors
                                                                          .green
                                                                          .shade800),
                                                            ),
                                                          ),
                                                          Text(
                                                              "${context.watch<Download>().segmentValue}%"),
                                                        ],
                                                      )
                                                    : SizedBox(),
                                              ),
                                              datam[index][0].endsWith(".pdf")
                                                  ? TextButton(
                                                      onPressed: () async {
                                                        String uri = await context
                                                            .read<Open>()
                                                            .downloadAndSavePdf(
                                                                datam[index]);

                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    Yuklashuchun(
                                                                        uri)));
                                                      },
                                                      child: Text("Ochish"),
                                                    )
                                                  : SizedBox(),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.only(bottom: _w / 20),
                                height: _w / 4,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 40,
                                      spreadRadius: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            // ListView.builder(
            //   itemBuilder: (context, index) {
            //     return ListTile(
            //       title: Text("${context.watch<Search>().javoblist[index]}"),
            //     );
            //   },
            //   itemCount: context.watch<Search>().javoblist.length,
            // )
          )
        ],
      ),
    );
  }

  typeFile(String end) {
    if (end.endsWith(".pdf")) {
      return "assets/images/pdf.png";
    }else if(end.endsWith(".docx")||end.endsWith(".doc")){
      return "assets/images/document.png";
    }else if(end.endsWith(".pptx")||end.endsWith(".ppt")){
      return "assets/images/pptx.png";
    }else if(end.endsWith(".zip")||end.endsWith(".rar")){
      return "assets/images/zip.png";
    }else if(end.endsWith(".apk")){
      return "assets/images/apk.png";
    }
  }

  TextStyle textfieldstyle() => TextStyle(color: Colors.white.withOpacity(.9));
}
