import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'moneytransfair/app.dart';
import 'motradis_home.dart';
import 'motradis_settings.dart';

void main() {
  runApp(new MoneyTransfairApp());
}

class MotradisApp extends StatelessWidget {

  final List<String> _symbols = <String>[];

  ThemeData get theme {
    return defaultTargetPlatform == TargetPlatform.iOS
        ? kIOSTehme
        : kDefaultTheme;
  }

  Route<Null> _getRoute(RouteSettings settings) {
    final List<String> path = settings.name.split('/');
    if (path[0] != '')
      return null;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'MoneyTransfair',
        theme: theme,
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => new MotradisHome(_symbols),
          '/settings': (BuildContext context) => new MotradisSettings()
        },
        onGenerateRoute: _getRoute
    );
  }
}

final ThemeData kIOSTehme = new ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.grey[100],
    primaryColorBrightness: Brightness.light
);

final ThemeData kDefaultTheme = new ThemeData(
    primarySwatch: Colors.purple,
    accentColor: Colors.orangeAccent[400]
);

class Motradis extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new MotradisState();
}

class MotradisState extends State<Motradis> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("MoneyTransfair"),
        elevation: Theme
            .of(context)
            .platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: new Container(
          decoration: Theme
              .of(context)
              .platform == TargetPlatform.iOS
              ? new BoxDecoration(
              border: new Border(top: new BorderSide(color: Colors.grey[200])))
              : null),
    );
  }
}
