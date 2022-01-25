import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("第三方跳转"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
                onPressed: () {
                  _launchURL("tel:13750034730");
                },
                child: Text("打电话")
            ),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  _launchURL("https://www.baidu.com");
                },
                child: Text("打开浏览器")
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL(String urlString) async =>
      await canLaunch(urlString) ? await launch(urlString) : throw 'Could not launch $urlString';
}
