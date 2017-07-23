
import 'dart:async';

import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:motradis/common/item.dart';
import 'package:motradis/common/updates.dart';

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
  const MoneyTransfairApp({
    this.updateUrlFetcher,
    this.enablePerformanceOverlay: true,
    this.checkerboardRasterCacheImages: true,
    this.checkerboardOffscreenLayers: true,
    this.onSendFeedback,
    Key key}
      ) : super(key: key);

  final UpdateUrlFetcher updateUrlFetcher;

  final bool enablePerformanceOverlay;

  final bool checkerboardRasterCacheImages;

  final bool checkerboardOffscreenLayers;

  final VoidCallback onSendFeedback;

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
    Widget home = new MoneytransfairHome(
      useLightTheme: _useLightTheme,
      onThemeChanged: (bool value) {
        setState(() {
          _useLightTheme = value;
        });
      },
      showPerformanceOverlay: _showPerformanceOverlay,
      onShowPerformanceOverlayChanged: widget.enablePerformanceOverlay ? (bool value) {
        setState(() {
          _showPerformanceOverlay = value;
        });
      } : null,
      checkerboardRasterCacheImages: _checkerboardRasterCacheImages,
      onCheckerboardRasterCacheImagesChanged: widget.checkerboardRasterCacheImages ? (bool value) {
        setState(() {
          _checkerboardRasterCacheImages = value;
        });
      } : null,
      checkerboardOffscreenLayers: _checkerboardOffscreenLayers,
      onCheckerboardOffscreenLayersChanged: widget.checkerboardOffscreenLayers ? (bool value) {
        setState(() {
          _checkerboardOffscreenLayers = value;
        });
      } : null,
      onPlatformChanged: (TargetPlatform value) {
        setState(() {
          _platform = value == defaultTargetPlatform ? null : value;
        });
      },
      timeDilation: _timeDilation,
      onTimeDilationChanged: (double value) {
        setState(() {
          _timeDilationTimer?.cancel();
          _timeDilationTimer = null;
          _timeDilation = value;
          if (_timeDilation > 1.0) {
            // We delay the time dilation change long enough that the user can see
            // that the checkbox in the drawer has started reacting, then we slam
            // on the brakes so that they see that the time is in fact now dilated.
            _timeDilationTimer = new Timer(const Duration(milliseconds: 150), () {
              timeDilation = _timeDilation;
            });
          } else {
            timeDilation = _timeDilation;
          }
        });
      },
      onSendFeedback: widget.onSendFeedback,
    );

    if (widget.updateUrlFetcher != null) {
      home = new Updater(
        updateUrlFetcher: widget.updateUrlFetcher,
        child: home,
      );
    }

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
