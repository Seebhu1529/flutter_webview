import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview/my_web_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const WebViewApp(),
    );
  }
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});
  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()..loadRequest(
      Uri.parse('https://www.ietbhaddal.edu.in'),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My WebView"),
        actions: [
          Row(
            children: [
              IconButton( icon: const Icon(Icons.arrow_back),
                onPressed: () async{
                final messenger = ScaffoldMessenger.of(context);
                if(await _controller.canGoForward()){
                  _controller.goBack();
                } else{
                  messenger.showSnackBar(const
                  SnackBar(content: Text("No forward history item")),
                  );
                  return;
                }
              },
            ),
              IconButton( icon: const Icon(Icons.arrow_forward),
                onPressed: () async{
                final messenger = ScaffoldMessenger.of(context);
                if(await _controller.canGoForward()){
                  _controller.goForward();
                } else{
                  messenger.showSnackBar(const
                  SnackBar(content: Text("No forward history item")),
                  );
                  return;
                }
              },
            ),
              IconButton(
                icon: const Icon(Icons.replay),
                    onPressed: () async{
                      _controller.reload();
                    }
              )
            ],
          )
        ],
      ),
      body: MyWebView(controller: _controller),

    );

  }
}
