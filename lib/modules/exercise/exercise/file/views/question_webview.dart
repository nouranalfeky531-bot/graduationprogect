import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class QuestionWebView extends StatefulWidget {
  final String url;

  const QuestionWebView({
    super.key,
    required this.url,
  });

  @override
  State<QuestionWebView> createState() => _QuestionWebViewState();
}

class _QuestionWebViewState extends State<QuestionWebView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller =
    WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Question"),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}