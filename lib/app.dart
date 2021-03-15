import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_101/routeGenerate.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;
  MyApp({this.client});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // var auth = FirebaseAuth.instance;
    // auth.signOut();
    // auth.currentUser;
    // print(auth.currentUser);
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        // home: MyHomePage(title: 'Flutter Demo Home Page'),
        initialRoute: 'home',
        onGenerateRoute: (RouteSettings setting) =>
            RouteGenerate.generateAuthRoute(setting),
      ),
      // builder: (BuildContext context, Widget child) => child,
    );
  }
}
