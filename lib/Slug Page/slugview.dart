import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wg_garment/Slug%20Page/slug_view_model.dart';
import 'package:html_unescape/html_unescape.dart';

class Slugview extends StatefulWidget {
  const Slugview({super.key});

  @override
  State<Slugview> createState() => _SlugviewState();
}

class _SlugviewState extends State<Slugview> {
  late final WebViewController _controller;

  late SlugViewModel _viewModel;
  bool _isInitialized = false;
  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
  }

  @override
  void dispose() {
    //_viewModel.clearData();
    super.dispose();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _viewModel = Provider.of<SlugViewModel>(context, listen: false);

      final response = await _viewModel.slugpageURL();
      if (response != null) {
        if (response.responseCode == 1) {
          Fluttertoast.showToast(msg: response.responseText ?? "");

          final unescape = HtmlUnescape();
          final rawHtml = response.responseData?.description ?? "";
          final decodedHtml = unescape.convert(rawHtml);

          // Inject frontend-controlled CSS wrapper
final frontendStyledHtml = '''
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
      body {
        font-size: 18px !important;
        line-height: 1.6 !important;
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif !important;
        padding: 16px;
        color: #333;
        background-color: #ffffff;
      }
      h1, h2, h3 {
        font-size: 20px !important;
        margin-top: 20px;
      }
      p {
        margin-bottom: 12px;
      }
      ul, ol {
        padding-left: 20px;
      }
      li {
        margin-bottom: 8px;
      }
      a {
        color: #007AFF;
        text-decoration: none;
      }
    </style>
  </head>
  <body>
    $decodedHtml
  </body>
</html>
''';


          _controller
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadHtmlString(frontendStyledHtml);

        }
      } else {
        Fluttertoast.showToast(msg: "Something went wrong!");
      }
      _isInitialized = true;
    }
  }



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

          Expanded(
            child: WebViewWidget(
              controller: _controller,
            ),
          )
        ],
      )),
    );
  }
}
