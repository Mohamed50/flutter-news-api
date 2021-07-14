import 'package:flutter/material.dart';
import 'package:news_app/view/customs/app-bar.dart';
import 'widgets/articles-section.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Home",
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Text("Latest news", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),),
          ArticlesSection()
        ],
      ),
    );
  }
}
