import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_view_authentication/constants/colors.dart';
import 'package:web_view_authentication/constants/constants.dart';
import 'package:web_view_authentication/screens/loading_screen.dart';
import 'package:web_view_authentication/screens/main_web_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebView Demo',
      theme: ThemeData(
        primarySwatch: primarySwatch,
      ),
      home: const WebViewPage(
        // url: Constants().mainUrl,
      ),
    );
  }
}
