import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_101/screens/home.dart';
import 'package:flutter_101/screens/login.dart';
import 'package:flutter_101/screens/sign_up.dart';
import 'package:flutter_101/screens/profile.dart';

class RouteGenerate {
  static generateAuthRoute(RouteSettings setting) {
    String routeName = 'login';

    // FirebaseAuth.instance.signOut();
    // if (user == null) {
    //   routeName = 'login';
    // }
    switch (routeName) {
      case 'home':
        return MaterialPageRoute(builder: (_) => Home());
      case 'profile':
        return MaterialPageRoute(builder: (_) => Profile());
      case 'login':
        return MaterialPageRoute(builder: (_) => Login());
      case 'signUp':
        return MaterialPageRoute(builder: (_) => SignUp());
      default:
    }
  }
}
