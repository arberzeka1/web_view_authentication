import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_view_authentication/constants/constants.dart';
import 'package:web_view_authentication/form.dart';
import 'package:web_view_authentication/network_hepler.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String? url;
  const WebViewPage({Key? key, this.url}) : super(key: key);
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController? webView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Engage Media"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => WebViewPage(
                    url: Constants().mainUrl,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.home,
            ),
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
              navigationDelegate: (NavigationRequest request) {
                NetworkHelper()
                    .checkStatus(url: Constants().pageUrl)
                    .then((value) async {
                  if (request.url == Constants().pageUrl && value == true) {
                    final data = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const FormScreen(),
                      ),
                    );

                    if (data == null || data is! String) return;
                    webView?.loadUrl(
                      Uri.dataFromString(data,
                              mimeType: 'text/html', encoding: utf8)
                          .toString(),
                    );
                  }
                });
                return NavigationDecision.navigate;
              },
            ),
          ),
        ],
      ),
    );
  }
}
