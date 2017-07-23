// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkTextSpan extends TextSpan {
  LinkTextSpan({TextStyle style, String url, String text})
      : super(
      style: style,
      text: text ?? url,
      recognizer: new TapGestureRecognizer()
        ..onTap = () {
          launch(url);
        });
}

class AppDrawerHeader extends StatefulWidget {
  const AppDrawerHeader({Key key, this.light}) : super(key: key);

  final bool light;

  @override
  _AppDrawerHeaderState createState() => new _AppDrawerHeaderState();
}

class _AppDrawerHeaderState extends State<AppDrawerHeader> {
  bool _logoHasName = true;
  bool _logoHorizontal = true;
  MaterialColor _logoColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    final double systemTopPadding = MediaQuery.of(context).padding.top;

    return new DrawerHeader(
        decoration: new FlutterLogoDecoration(
          margin: new EdgeInsets.fromLTRB(12.0, 12.0 + systemTopPadding, 12.0, 12.0),
          style: _logoHasName ? _logoHorizontal ? FlutterLogoStyle.horizontal : FlutterLogoStyle.stacked : FlutterLogoStyle.markOnly,
          lightColor: _logoColor.shade400,
          darkColor: _logoColor.shade900,
          textColor: widget.light ? const Color(0xFF616161) : const Color(0xFF9E9E9E),
        ),
        duration: const Duration(milliseconds: 750),
        child: new GestureDetector(onLongPress: () {
          setState(() {
            _logoHorizontal = !_logoHorizontal;
            if (!_logoHasName) _logoHasName = true;
          });
        }, onTap: () {
          setState(() {
            _logoHasName = !_logoHasName;
          });
        }, onDoubleTap: () {
          setState(() {
            final List<MaterialColor> options = <MaterialColor>[];
            if (_logoColor != Colors.blue) options.addAll(<MaterialColor>[Colors.blue, Colors.blue, Colors.blue, Colors.blue, Colors.blue, Colors.blue, Colors.blue]);
            if (_logoColor != Colors.amber) options.addAll(<MaterialColor>[Colors.amber, Colors.amber, Colors.amber]);
            if (_logoColor != Colors.red) options.addAll(<MaterialColor>[Colors.red, Colors.red, Colors.red]);
            if (_logoColor != Colors.indigo) options.addAll(<MaterialColor>[Colors.indigo, Colors.indigo, Colors.indigo]);
            if (_logoColor != Colors.pink) options.addAll(<MaterialColor>[Colors.pink]);
            if (_logoColor != Colors.purple) options.addAll(<MaterialColor>[Colors.purple]);
            if (_logoColor != Colors.cyan) options.addAll(<MaterialColor>[Colors.cyan]);
            _logoColor = options[new math.Random().nextInt(options.length)];
          });
        }));
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle aboutTextStyle = themeData.textTheme.body2;
    final TextStyle linkStyle = themeData.textTheme.body2.copyWith(color: themeData.accentColor);

    final Widget aboutItem = new AboutListTile(
        icon: const Icon(Icons.info),
        applicationVersion: 'June 2017 Preview',
        //applicationIcon: const FlutterLogo(),
        applicationLegalese: '© 2017 Moneytransfair',
        aboutBoxChildren: <Widget>[
          new Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: new RichText(
                  text: new TextSpan(children: <TextSpan>[
                    new TextSpan(style: aboutTextStyle, text: "Welcome to MoneyTransfair! International Money Transfers cheap, easy and fast! "),
                    new LinkTextSpan(style: linkStyle, url: 'https://github.com/merlinfotsing/motradis'),
                new TextSpan(
                    style: aboutTextStyle,
                    text: ".\n\nMoneyTransfair is an online Money Transfer Service. Use your smarthphone, "
                        " tablet or Desktop to make international Transfers. Why MoneyTransfair"
                        " Your loved-ones can receive through cash pick-up, bank Transfer, airtime top-up or mobile Money."),
                new TextSpan(
                    style: linkStyle,
                    text: 'To use our Service you don\'t need a bank account. learn More '
                        ' Get Money back by participating in our refund Programme. learn More'
                        ' Send Money - 3 simple steps')
                  ])))
        ]);

    return new Drawer(
      child: new ListView(
        children: <Widget>[
          const DrawerHeader(child: const Center(child: const Text('Moneytransfair'))),
          const ListTile(
            title: const Text('Profil'),
            selected: true,
          ),
          const ListTile(
            title: const Text('Transfairlist'),
            enabled: false,
          ),
          const Divider(),
          new ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => Navigator.popAndPushNamed(context, '/settings'),
          ),
          new ListTile(
            leading: const Icon(Icons.help),
            title: const Text('About Us'),
            onTap: () => aboutItem,
          ),
        ],
      ),
    );
  }
}
