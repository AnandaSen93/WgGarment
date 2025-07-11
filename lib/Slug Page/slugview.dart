import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Slugview extends StatefulWidget {
  const Slugview({super.key});

  @override
  State<Slugview> createState() => _SlugviewState();
}

class _SlugviewState extends State<Slugview> {

    late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://flutter.dev'));  
     // ..loadHtmlString(_htmlData);
  }

  final String _htmlData = '''
    <!DOCTYPE html>
    <html>
    <body>
      <h2>Hello Flutter WebView</h2>
      <p>This is an <b>HTML text</b> with a <a href="https://flutter.dev">link</a>.</p>
    </body>
    </html>
  ''';

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: SafeArea(
        child: Column(
          children: [
               // Header
          Container(
            color: Colors.transparent,
            height: 60,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new)),
                SizedBox(width: 80),
                Image.asset(
                  'assets/images/app_logo.png',
                  fit: BoxFit.contain,
                ),
                Spacer()
              ],
            ),
          ),

          Expanded(child: WebViewWidget(controller: _controller))
          ],

        )
      ),
    );
  }
}