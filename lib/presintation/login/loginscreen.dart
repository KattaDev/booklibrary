import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ilmtop/data/servise/servisauth.dart';
import 'package:ilmtop/presintation/home/homescreen.dart';

class MyCustomLoginUI extends StatefulWidget {
  @override
  _MyCustomLoginUIState createState() => _MyCustomLoginUIState();
}

class _MyCustomLoginUIState extends State<MyCustomLoginUI>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Services _apiService = Helper();
  var _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: .7, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    )
      ..addListener(
        () {
          setState(() {});
        },
      )
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            _controller.reverse();
          } else if (status == AnimationStatus.dismissed) {
            _controller.forward();
          }
        },
      );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff212C31),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: _height,
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.17,
                    ),
                    Text(
                      'KIRISH',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.cyanAccent,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: _width / 8,
                              width: _width / 1.22,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(right: _width / 30),
                              decoration: BoxDecoration(
                                color: Color(0xff212428),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.length < 3) {
                                    return "Uchta harfdan kam bo'lmasin";
                                  }
                                },
                                controller: _apiService.nameController,
                                style: textfieldstyle(),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle_outlined,
                                    color: Colors.white.withOpacity(.7),
                                  ),
                                  border: InputBorder.none,
                                  hintMaxLines: 1,
                                  hintText: 'Ismingiz...',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(.5),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            Container(
                              height: _width / 8,
                              width: _width / 1.22,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(right: _width / 30),
                              decoration: BoxDecoration(
                                color: Color(0xff212428),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.length < 11) {
                                    return "Xato raqam";
                                  }
                                },
                                controller: _apiService.phoneController,
                                style: textfieldstyle(),
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.phone_outlined,
                                    color: Colors.white.withOpacity(.7),
                                  ),
                                  border: InputBorder.none,
                                  hintMaxLines: 1,
                                  hintText: 'Raqamingiz...',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(.5),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            Container(
                              height: _width / 8,
                              width: _width / 1.22,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(right: _width / 30),
                              decoration: BoxDecoration(
                                color: Color(0xff212428),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.length < 3) {
                                    return "Uchta belgidan kam bo'lmasin";
                                  }
                                },
                                controller: _apiService.passwordController,
                                obscureText: true,
                                style: textfieldstyle(),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: Colors.white.withOpacity(.7),
                                  ),
                                  border: InputBorder.none,
                                  hintMaxLines: 1,
                                  hintText: 'Maxfiy so\'z...',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(.5),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Forgotten password!',
                            style: TextStyle(
                              color: Colors.cyanAccent,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                HapticFeedback.lightImpact();
                                Fluttertoast.showToast(
                                    msg: 'Iltimos to\'ldiring!');
                              },
                          ),
                        ),
                        SizedBox(width: _width / 10),
                        RichText(
                          text: TextSpan(
                            text: 'Create a new Account',
                            style: TextStyle(
                              color: Colors.cyanAccent,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                HapticFeedback.lightImpact();
                                Fluttertoast.showToast(
                                  msg: 'Ro\'yxatdan o\'ting!',
                                );
                              },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: _width * .07),
                          height: _width * .7,
                          width: _width * .7,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                                Color(0xff09090A),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Transform.scale(
                          scale: _animation.value,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                await _apiService.sendMessageuser();

                                HapticFeedback.lightImpact();
                                Fluttertoast.showToast(
                                  msg: 'Kirish muvaffaqiyatli!',
                                );
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              } else {}
                            },
                            child: Container(
                              height: _width * .2,
                              width: _width * .2,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.cyanAccent,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                'KIRISH',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle textfieldstyle() => TextStyle(color: Colors.white.withOpacity(.9));
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
