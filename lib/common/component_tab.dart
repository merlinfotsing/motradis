import 'package:flutter/material.dart';
import 'package:motradis/moneytransfair/syntax_highlighter.dart';
import 'package:motradis/common/app_theme.dart';

class ComponentTabData {
  ComponentTabData({this.widget, this.codeTag, this.description, this.tabName});

  final Widget widget;
  final Widget codeTag;
  final Widget description;
  final String tabName;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType)
      return false;
    final ComponentTabData typedOther = other;
    return typedOther.tabName == tabName &&
        typedOther.description == description;
  }

  @override
  int get hashCode => hashValues(tabName.hashCode, description.hashCode);

}

class TabbedComponentScaffold extends StatelessWidget {
  TabbedComponentScaffold({this.components, this.title, this.isMultiTab}) :
        assert(isMultiTab != null);

  final List<ComponentTabData> components;
  final String title;
  final bool isMultiTab;
  final double _appBarElevation = 0.0;

  void _showViewCode(BuildContext context) {
    final Widget tag = components[DefaultTabController
        .of(context)
        .index].codeTag;
    if (tag != null) {
      Navigator.push(context, new MaterialPageRoute(
          builder: (BuildContext context) =>
          new FullScreenCodeDialog(
              codeTag: tag)));
    }
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return new DefaultTabController(
      length: components.length,
      child: new Scaffold(
        appBar: new AppBar(
          flexibleSpace: new Container(decoration: new BoxDecoration(
              border: new Border(
                  bottom: new BorderSide(color: theme.dividerColor)))),
          elevation: _appBarElevation,
          backgroundColor: theme.appBarBackgroundColor,
          iconTheme: Theme
              .of(context)
              .iconTheme,
          brightness: Brightness.light,
          title: new Center(child: new Text(title, style: AppTheme
              .of(context)
              .appBarTitleStyle)),
          actions: <Widget>[
            new IconButton(
                icon: const Icon(Icons.add_alert),
                tooltip: 'New Alert',
                onPressed: () {
                  _showViewCode(context);
                }
            ),
            /*new Builder(
              builder: (BuildContext context) {
                return new IconButton(
                  icon: const Icon(Icons.description),
                  tooltip: 'Show example code',
                  onPressed: () {
                    _showViewCode(context);
                  },
                );
              },
            ),*/
          ],
          bottom: isMultiTab ? new TabBar(
            isScrollable: true,
            tabs: components.map((ComponentTabData data) =>
            new Tab(text: data.tabName)).toList(),
          ) : null,
        ),
        body: new TabBarView(
          children: components.map((ComponentTabData component) {
            return new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: component.description,
                  /*child: new Text(component.description,
                        style: Theme
                            .of(context)
                            .textTheme
                            .subhead
                    )*/
                ),
                new Expanded(child: component.widget)
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class FullScreenCodeDialog extends StatefulWidget {
  const FullScreenCodeDialog({ this.codeTag });

  final Widget codeTag;

  @override
  FullScreenCodeDialogState createState() => new FullScreenCodeDialogState();
}

class FullScreenCodeDialogState extends State<FullScreenCodeDialog> {

  Widget _code;

  @override
  void didChangeDependencies() {
    setState(() => widget.codeTag);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final SyntaxHighlighterStyle style = Theme
        .of(context)
        .brightness == Brightness.dark
        ? SyntaxHighlighterStyle.darkThemeStyle()
        : SyntaxHighlighterStyle.lightThemeStyle();

    Widget body;
    if (_code == null) {
      body = const Center(
          child: const CircularProgressIndicator()
      );
    } else {
      body = new SingleChildScrollView(
          child: new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new RichText(
                  text: new TextSpan(
                      style: const TextStyle(
                          fontFamily: 'monospace', fontSize: 10.0),
                      children: <TextSpan>[
                        new DartSyntaxHighlighter(style).format(
                            _code.toString())
                      ]
                  )
              )
          )
      );
    }

    return new Scaffold(
        appBar: new AppBar(
            leading: new IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  Navigator.pop(context);
                }
            ),
            title: const Text('Example code')
        ),
        body: body
    );
  }
}