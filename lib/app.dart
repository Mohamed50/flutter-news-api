import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:news_app/config/theme.dart';
import 'package:news_app/utils/routes.dart';
import 'package:news_app/viewModel/article-view-model.dart';
import 'package:news_app/viewModel/setting-view-model.dart';
import 'package:provider/provider.dart';
import 'view/customs/settings-handler.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context) => SettingViewModel(), lazy: false,),
        ChangeNotifierProvider(create:(context) => ArticleViewModel(), lazy: false,),
      ],
      child: SettingHandler(
        builder: (context, setting) => MaterialApp(
          title: "News App",
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          routes: routes,
          themeMode: setting.themeMode,
          locale: setting.locale,
          supportedLocales: setting.supportedLocales,
          theme: lightTheme,
          darkTheme: darkTheme,
        ),
      ),
    );
  }
}
