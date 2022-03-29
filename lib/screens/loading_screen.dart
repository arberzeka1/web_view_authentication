import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_view_authentication/constants/colors.dart';
import 'package:web_view_authentication/helpers/network_hepler.dart';
import 'package:web_view_authentication/screens/form.dart';
import 'package:web_view_authentication/screens/second_web_view.dart';

class LoadingScreen extends StatefulWidget {
  final String? url;
  const LoadingScreen({Key? key, this.url}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late bool status;
  @override
  void initState() {
    checkToken();
    super.initState();
  }

  void checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('action');
    await NetworkHelper()
        .checkStatus(url: "https://demo.engagemedia.at/page")
        .then((value) {
      status = value;
    });

    if (token != null && status == false) {
      var date = await NetworkHelper().authenticate();

      // var url = Uri.dataFromString(date, mimeType: 'text/html', encoding: utf8)
      //     .toString();
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              const SecondWebViewPage(url: "https://demo.engagemedia.at/pubic"),
        ),
      );
    } else if (token == null || status == true) {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const FormScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarySwatch,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Engage Madia',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
