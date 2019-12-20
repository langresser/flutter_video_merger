import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/i18n.dart';
import 'pages/video_cache_page.dart';

void main() {
  // 类型检查
  Provider.debugCheckInvalidValueType = null;

  // 启动app
  runApp(MyApp());

  // Android状态栏透明 splash为白色,所以调整状态栏文字为黑色
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Video Merger",
      onGenerateTitle: (context) => I18n.of(context).appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VideoCachePage(),

      // 多语言支持
      localizationsDelegates: [
        // 自定义多语言
        I18n.delegate,
        // 系统多语言
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: I18n.delegate.supportedLocales,
    );
  }
}
