import 'package:flutter/material.dart';
import 'package:web_view_authentication/constants/colors.dart';
import 'package:web_view_authentication/constants/constants.dart';
import 'package:web_view_authentication/screens/main_web_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebView Demo',
      theme: ThemeData(
        primarySwatch: primarySwatch,
      ),
      home: WebViewPage(
        url: Constants().mainUrl,
      ),
    );
  }
}
