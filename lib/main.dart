import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenges2022/register-form/register.dart';

import 'package:get/get.dart';

import 'firebase_options.dart';

void main()  async {
   WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
       );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.grey,
      ),

      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SignUpScreen(),
      )
    );
  }
}
