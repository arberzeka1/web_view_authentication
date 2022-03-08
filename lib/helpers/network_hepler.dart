import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';

class NetworkHelper {
  Future<dynamic> getToken({String? username, String? password}) async {
    return await http.post(
      Uri.parse(Constants().loginUrl),
      body: {
        "username": "$username",
        "password": "$password",
      },
    ).then((value) {
      var resp = json.decode(value.body)['access_token'];
      return resp;
    });
  }

  Future<bool> checkStatus({String? url}) async {
    final response = await http.get(Uri.parse(url!));
    if (response.statusCode == 401) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> authenticate({String? token}) async {
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
