import 'dart:async';

import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:motradis/common/item.dart';

import 'home.dart';

final Map<String, WidgetBuilder> _kRoutes = new Map<String, WidgetBuilder>.fromIterable(
  kAllAppItems,
  key: (AppItem item) => item.routeName,
  value: (AppItem item) => item.buildRoute,
);

final ThemeData _kMoneytransfairLightTheme = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
);

final ThemeData _kMoneytransfairDarkTheme = new ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blue,
);

class MoneyTransfairApp extends StatefulWidget {
  const MoneyTransfairApp({Key key}) : super(key: key);

  @override
  MoneytransfairAppState createState() => new MoneytransfairAppState();
}

class MoneytransfairAppState extends State<MoneyTransfairApp> {
  bool _useLightTheme = true;
  bool _showPerformanceOverlay = false;
  bool _checkerboardRasterCacheImages = false;
  bool _checkerboardOffscreenLayers = false;
  double _timeDilation = 1.0;
  TargetPlatform _platform;

  Timer _timeDilationTimer;

  @override
  void initState() {
    _timeDilation = timeDilation;
    super.initState();
  }

  @override
  void dispose() {
    _timeDilationTimer?.cancel();
    _timeDilationTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget home = new MoneytransfairHome();

    return new MaterialApp(
      title: 'Moneytransfair',
      color: Colors.grey,
      theme: (_useLightTheme ? _kMoneytransfairLightTheme : _kMoneytransfairDarkTheme).copyWith(platform: _platform ?? defaultTargetPlatform),
      showPerformanceOverlay: _showPerformanceOverlay,
      checkerboardRasterCacheImages: _checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: _checkerboardOffscreenLayers,
      routes: _kRoutes,
      home: home,
    );
  }
}
