import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWrapper extends StatefulWidget {
  final String initialUrl;

  const WebViewWrapper({
    Key key,
    @required this.initialUrl,
  }) : super(key: key);

  @override
  _WebViewWrapperState createState() => _WebViewWrapperState();
}

class _WebViewWrapperState extends State<WebViewWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int _stackToView = 1;

  void _handleLoad(String value) {
    setState(() {
      _stackToView = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    assert(widget.initialUrl != null);

    return IndexedStack(
      children: <Widget>[
        WebView(
          initialUrl: widget.initialUrl,
          gestureRecognizers: Set()
            ..add(
              Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer()..onUpdate = (_) {}),
            ),
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: _handleLoad,
        ),
        Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
      index: _stackToView,
    );
  }
}

class EmbeddedWeb {
  final String title;
  final String url;

  EmbeddedWeb({
    this.title,
    this.url,
  });
}
