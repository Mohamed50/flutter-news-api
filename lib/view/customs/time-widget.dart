import 'package:flutter/material.dart';
import 'package:news_app/viewModel/setting-view-model.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class TimeAgoText extends StatelessWidget {
  final DateTime time;
  final TextStyle style;
  final TextAlign textAlign;
  const TimeAgoText(this.time,{Key key, this.style, this.textAlign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<SettingViewModel, Locale>(
      selector: (_, provider) => provider.locale,
      builder: (context, locale, child) => Text(
        timeago.format(time, locale: locale.languageCode),
        style: style,
        textAlign: textAlign,
      ),
    );
  }
}
