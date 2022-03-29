import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_view_authentication/screens/form.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SecondWebViewPage extends StatefulWidget {
  final String? url;
  const SecondWebViewPage({Key? key, this.url}) : super(key: key);
  @override
  _SecondWebViewPageState createState() => _SecondWebViewPageState();
}

class _SecondWebViewPageState extends State<SecondWebViewPage> {
  WebViewController? webView;
  bool isLoading = false;
  bool isTokenSaved = false;
  String? urls;
  dynamic token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Engage Media"),
        actions: [
          GestureDetector(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const FormScreen(),
                ),
              );
            },
            child: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController? controller) {
                webView = controller;
              },
              navigationDelegate: (NavigationRequest request) async {
                // var value =
                // await NetworkHelper().checkStatus(url: request.url);
                // print(value);
                //
                // if (value == true ) {
                //   final data = await Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (BuildContext context) =>
                //       const FormScreen(),
                //     ),
                //   );
                //
                //   // if (data == null || data is! String)
                //   //   return ;
                //   webView?.loadUrl(
                //     Uri.dataFromString(data,
                //         mimeType: 'text/html', encoding: utf8)
                //         .toString(),
                //   );
                //   setState(() {
                //     isTokenSaved = true;
                //   });
                // } else {
                //   if (request.url == "https://demo.engagemedia.at/page") {
                //     SharedPreferences prefs =
                //     await SharedPreferences.getInstance();
                //     var token = prefs.getString('action');
                //     if (token != null) {
                //       date = await NetworkHelper().authenticate();
                //       await webView?.loadUrl(
                //         Uri.dataFromString(date,
                //             mimeType: 'text/html', encoding: utf8)
                //             .toString(),
                //       );
                //
                //
                //     }
                //   }
                //
                //   setState(() {
                //     isLoading = false;});
                // }
                return NavigationDecision.navigate;
              },
            ),
          ),
        ],
      ),
    );
  }
}
