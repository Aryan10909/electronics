// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:electronicsshop/admin/addproduct.dart';
import 'package:electronicsshop/admin/adminlogin.dart';
import 'package:electronicsshop/pages/bottomnav.dart';
import 'package:electronicsshop/pages/home.dart';
import 'package:electronicsshop/pages/login.dart';
import 'package:electronicsshop/pages/onboarding.dart';
import 'package:electronicsshop/pages/productdetail.dart';
import 'package:electronicsshop/pages/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyDe7nc03wISL-D8A7pWImNoU7S7SaQlLIc",
              appId: "1:455896245296:android:c7c20874f094a880e7f9f5",
              messagingSenderId: "455896245296",
              projectId: "electronicsshop-a55df",
              storageBucket: "electronicsshop-a55df.appspot.com"))
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUp(),
    );
  }
}
