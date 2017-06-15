// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:motradis/common/drawer.dart';
import 'package:motradis/common/item.dart';

const double _kFlexibleSpaceMaxHeight = 150.0;

class _BackgroundLayer {
  _BackgroundLayer({ int level, double parallax })
      : assetName = 'packages/flutter_gallery_assets/appbar/appbar_background_layer$level.png',
        parallaxTween = new Tween<double>(begin: 0.0, end: parallax);
  final String assetName;
  final Tween<double> parallaxTween;
}

final List<_BackgroundLayer> _kBackgroundLayers = <_BackgroundLayer>[
  new _BackgroundLayer(level: 0, parallax: _kFlexibleSpaceMaxHeight),
  new _BackgroundLayer(level: 1, parallax: _kFlexibleSpaceMaxHeight),
  new _BackgroundLayer(level: 2, parallax: _kFlexibleSpaceMaxHeight / 2.0),
  new _BackgroundLayer(level: 3, parallax: _kFlexibleSpaceMaxHeight / 4.0),
  new _BackgroundLayer(level: 4, parallax: _kFlexibleSpaceMaxHeight / 2.0),
  new _BackgroundLayer(level: 5, parallax: _kFlexibleSpaceMaxHeight)
];

class _AppBarBackground extends StatelessWidget {
  const _AppBarBackground({ Key key, this.animation }) : super(key: key);

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget child) {
          return new Stack(
              children: _kBackgroundLayers.map((_BackgroundLayer layer) {
                return new Positioned(
                    top: -layer.parallaxTween.evaluate(animation),
                    left: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    child: new Image.asset(
                        layer.assetName,
                        fit: BoxFit.cover,
                        height: _kFlexibleSpaceMaxHeight
                    )
                );
              }).toList()
          );
        }
    );
  }
}

class MoneytransfairHome extends StatefulWidget {
  MoneytransfairHome({
    Key key,
    this.useLightTheme,
    @required this.onThemeChanged,
    this.timeDilation,
    @required this.onTimeDilationChanged,
    this.showPerformanceOverlay,
    this.onShowPerformanceOverlayChanged,
    this.checkerboardRasterCacheImages,
    this.onCheckerboardRasterCacheImagesChanged,
    this.checkerboardOffscreenLayers,
    this.onCheckerboardOffscreenLayersChanged,
    this.onPlatformChanged,
    this.onSendFeedback,
  }) : super(key: key) {
    assert(onThemeChanged != null);
    assert(onTimeDilationChanged != null);
  }

  final bool useLightTheme;
  final ValueChanged<bool> onThemeChanged;

  final double timeDilation;
  final ValueChanged<double> onTimeDilationChanged;

  final bool showPerformanceOverlay;
  final ValueChanged<bool> onShowPerformanceOverlayChanged;

  final bool checkerboardRasterCacheImages;
  final ValueChanged<bool> onCheckerboardRasterCacheImagesChanged;

  final bool checkerboardOffscreenLayers;
  final ValueChanged<bool> onCheckerboardOffscreenLayersChanged;

  final ValueChanged<TargetPlatform> onPlatformChanged;

  final VoidCallback onSendFeedback;

  @override
  MoneytransfairHomeState createState() => new MoneytransfairHomeState();
}

class MoneytransfairHomeState extends State<MoneytransfairHome>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<
      ScaffoldState>();

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 600),
      debugLabel: 'preview banner',
      vsync: this,
    )
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _moneytransfairListItems() {
    final List<Widget> listItems = <Widget>[];
    for (AppItem appItem in kAllAppItems) {
      listItems.add(appItem);
    }
    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    Widget home = new Scaffold(
        key: _scaffoldKey,
        drawer: new AppDrawer(
          useLightTheme: widget.useLightTheme,
          onThemeChanged: widget.onThemeChanged,
          timeDilation: widget.timeDilation,
          onTimeDilationChanged: widget.onTimeDilationChanged,
          showPerformanceOverlay: widget.showPerformanceOverlay,
          onShowPerformanceOverlayChanged: widget
              .onShowPerformanceOverlayChanged,
          checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
          onCheckerboardRasterCacheImagesChanged: widget
              .onCheckerboardRasterCacheImagesChanged,
          checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
          onCheckerboardOffscreenLayersChanged: widget
              .onCheckerboardOffscreenLayersChanged,
          onPlatformChanged: widget.onPlatformChanged,
          onSendFeedback: widget.onSendFeedback,
        ),
        body: new CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              pinned: true,
              expandedHeight: _kFlexibleSpaceMaxHeight,
              flexibleSpace: const FlexibleSpaceBar(
                title: const Text('Moneytransfair'),
                // TODO(abarth): Wire up to the parallax in a way that doesn't pop during hero transition.
                background: const _AppBarBackground(
                    animation: kAlwaysDismissedAnimation),
              ),
            ),
            new SliverList(delegate: new SliverChildListDelegate(
                _moneytransfairListItems())),
          ],
        )
    );

    // In checked mode our MaterialApp will show the default "slow mode" banner.
    // Otherwise show the "preview" banner.
    bool showPreviewBanner = true;
    assert(() {
      showPreviewBanner = false;
      return true;
    });

    if (showPreviewBanner) {
      home = new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            home,
            new FadeTransition(
                opacity: new CurvedAnimation(
                    parent: _controller, curve: Curves.easeInOut),
                child: const Banner(
                  message: 'PREVIEW',
                  location: BannerLocation.topRight,
                )
            ),
          ]
      );
    }

    return home;
  }
}