// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:motradis/material/invoice.dart';
import 'package:motradis/material/sign_in.dart';
import 'package:motradis/common/app_theme.dart';

typedef Widget AppBuilder();

class AppItem extends StatelessWidget {
  AppItem({
    @required this.title,
    this.subtitle,
    @required this.routeName,
    @required this.buildRoute,
  }) {
    assert(title != null);
    assert(routeName != null);
    assert(buildRoute != null);
  }

  final String title;
  final String subtitle;
  final String routeName;
  final WidgetBuilder buildRoute;

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(title),
      subtitle: new Text(subtitle),
      onTap: () {
        if (routeName != null) {
          Timeline.instantSync('Start Transition', arguments: <String, String>{
            'from': '/',
            'to': routeName
          });
          Navigator.pushNamed(context, routeName);
        }
      }
    );
  }
}

Widget _buildPage(BuildContext context, Widget child) {
  return new Theme(
      data: new ThemeData(
        primarySwatch: Colors.grey,
        iconTheme: const IconThemeData(color: const Color(0xFF707070)),
        platform: Theme.of(context).platform,
      ),
      child: new AppTheme(child: child)
  );
}

List<AppItem> _buildAppItems() {
  final List<AppItem> appItems = <AppItem>[
    new AppItem(
      title: 'Send',
      subtitle: 'Send your money with fair cost',
      routeName: InvoiceWidget.routeName,
      buildRoute: (BuildContext context) => new InvoiceWidget(),
    ),
    new AppItem(
      title: 'Sign in / Registration',
      subtitle: 'Sign in or register a new account',
      routeName: SignIn.routeName,
      buildRoute: (BuildContext context) => _buildPage(context, new SignIn()),
    )
  ];
  return appItems;
}

final List<AppItem> kAllAppItems = _buildAppItems();
