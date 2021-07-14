import 'package:flutter/material.dart';
import 'package:news_app/utils/routes.dart';
import 'package:news_app/view/customs/translatable-text.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    init();
    super.initState();
  }

  Future init() async{
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).pushNamed(homeRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TranslatableText("Loading..."),
            SizedBox(width: 8.0),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
