import 'package:flutter/material.dart';

class MotradisSettings extends StatefulWidget {

  @override
  MotradisSettingsState createState() => new MotradisSettingsState();
}

class MotradisSettingsState extends State<MotradisSettings> {
  Widget buildAppBar(BuildContext context) {
    return new AppBar(
        title: const Text('Settings')
    );
  }

  Widget buildSettingsPane(BuildContext context) {
    final List<Widget> rows = <Widget>[];
    assert(() {
      // material grid and size construction lines are only available in checked mode
      rows.addAll(<Widget>[
      ]);
      return true;
    });
    return new ListView(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      children: rows,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: buildAppBar(context),
        body: buildSettingsPane(context)
    );
  }
}
