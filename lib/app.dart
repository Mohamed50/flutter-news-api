import 'package:flutter/material.dart';
import 'package:news_app/utils/routes.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
    );
  }
}
