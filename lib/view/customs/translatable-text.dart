import 'package:news_app/viewModel/setting-view-model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TranslatableText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextDirection textDirection;
  final TextAlign textAlign;
  final int maxLines;

  const TranslatableText(this.text,{Key key, this.style, this.textDirection, this.textAlign, this.maxLines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<SettingViewModel,Map>(
      selector: (context, provider) => provider.localizedValues,
      builder: (context, localizedValues, child) => Text(
        localizedValues == null || localizedValues[text] == null ? text : localizedValues[text],
        style: style,
        textDirection: textDirection,
        textAlign: textAlign,
        maxLines: maxLines,
      ),
    );
  }
}
