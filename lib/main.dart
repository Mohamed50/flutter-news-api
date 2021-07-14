import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'app.dart';

void main() {
  timeago.setLocaleMessages('ar', timeago.ArMessages());
  runApp(App());
}
