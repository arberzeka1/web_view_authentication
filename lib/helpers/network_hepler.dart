import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_view_authentication/helpers/shared_preferences.dart';

import '../constants/constants.dart';

class NetworkHelper  {

  Future<dynamic> getToken({String? username, String? password}) async {
    SharedPreferences prefs =await  SharedPreferences.getInstance();
    var response =  await http.post(
      Uri.parse(Constants().loginUrl),
      body: {
        "username": "$username",
        "password": "$password",
      },
    );
      var token = json.decode(response.body)['access_token'];
    await prefs.setString('action', '$token');
      return token;

  }

  Future<bool> checkStatus({String? url}) async {
    final response = await http.get(Uri.parse(url!));
    if (response.statusCode == 200) {
      return false;
    } else {
      return true;
    }
  }

  Future<dynamic> authenticate() async {
    SharedPreferences prefs =await  SharedPreferences.getInstance();
    var token =  prefs.getString('action');
    return await http.get(
      Uri.parse(Constants().pageUrl),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    ).then((value) {
      return value.body;
    });
  }
}
