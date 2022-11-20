import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:first_app/model/splace_screen.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import 'model/skip.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent));

    
  // SystemChrome.setSystemUIOverlayStyle(
  //     SystemUiOverlayStyle(statusBarBrightness: Brightness.light,statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(name());
}

class name extends StatefulWidget {
  name({Key? key}) : super(key: key);

  @override
  State<name> createState() => _nameState();
}

class _nameState extends State<name> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final Future<FirebaseApp> _initialize = Firebase.initializeApp();
  late StreamSubscription<User?> user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((event) {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    user.cancel();
  }

  final Future<FirebaseApp> initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            theme: ThemeData(
                textTheme: ThemeData.light().textTheme.copyWith(
                    titleLarge: TextStyle(
                        // fontStyle:FontStyle.italic,
                        // fontSize: 20,
                        // fontWeight: FontWeight.bold,
                        fontFamily: "Sch"))),
            home: Scaffold(
                body: Center(
              child: Text("no data found yet !"),
            )),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Material(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home:

                  // Profile_ui(),
                  FirebaseAuth.instance.currentUser != null ? splash() : Skip(),
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
