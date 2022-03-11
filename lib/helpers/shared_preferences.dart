import 'package:shared_preferences/shared_preferences.dart';
class SharedPreference {
  // ignore: non_constant_identifier_names
  var TOKEN_KEY = "user_id";


  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(TOKEN_KEY) ?? "";
  }

  Future<Future<bool>> setToken(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(TOKEN_KEY, id);
  }
}
