import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'app.dart';
import 'gql/client.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await Firebase.initializeApp();
    await initHiveForFlutter();
    var client = await gqlClient();
    runApp(MyApp(client: client));
  } catch (error) {
    print('main.dart $error');
  }
}
