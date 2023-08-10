import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ADF',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final String pdfUrl = 'https://adf.gov.sa/ar/ServicesCatalog/Eservices_UserManaul/Documents/Eservices_UM2022.pdf';
  final String webpageUrl = 'https://adf.gov.sa/ar/Pages/default.aspx';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADF'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
              width: 250,
              height: 150,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfViewerScreen(pdfUrl: pdfUrl),
                  ),
                );
              },
              child: Text('User Guide'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebPageViewerScreen(webpageUrl: webpageUrl),
                  ),
                );
              },
              child: Text('Home Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class PdfViewerScreen extends StatelessWidget {
  final String pdfUrl;

  PdfViewerScreen({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADF User Guide'),
      ),
      body: PDF(
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        onError: (error) {
          print(error.toString());
        },
      ).cachedFromUrl(
        pdfUrl,
        errorWidget: (error) => Center(
          child: Text(
            'Error loading PDF!',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}

class WebPageViewerScreen extends StatelessWidget {
  final String webpageUrl;

  WebPageViewerScreen({required this.webpageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADF Home Page'),
      ),
      body: WebView(
        initialUrl: webpageUrl,
      ),
    );
  }
}