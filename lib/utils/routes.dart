import 'package:flutter/material.dart';
import 'package:news_app/view/article.dart';
import 'package:news_app/view/home.dart';
import 'package:news_app/view/splash.dart';

const String splashRoute = '/';
const String homeRoute = '/home';
const String articleRoute = '/article';


Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  splashRoute: (_) => SplashPage(),
  homeRoute: (_) => HomePage(),
  articleRoute: (_) => ArticlePage(),
};
