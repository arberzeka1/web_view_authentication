import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_view_authentication/constants/constants.dart';
import 'package:web_view_authentication/screens/loading_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String? url;
  const WebViewPage({Key? key, this.url}) : super(key: key);
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController? webView;
  bool isLoading = false;
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Engage Media"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: WebView(
              initialUrl: Constants().mainUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController? controller) {
                webView = controller;
              },
              navigationDelegate: (NavigationRequest request) async {
                if (request.url.toString() ==
                    "https://demo.engagemedia.at/page") {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => LoadingScreen(
                        url: request.url,
                      ),
                    ),
                  );
                }
                return NavigationDecision.navigate;
              },
            ),
          ),
        ],
      ),
    );
  }
}
