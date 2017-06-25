import 'package:flutter/material.dart';
import 'package:motradis/common/component_tab.dart';

class SignIn extends StatefulWidget {

  static const String routeName = '/material//login';

  @override
  _SignInState createState() => new _SignInState();
}

class _SignInState extends State<SignIn> {

  @override
  Widget build(BuildContext context) {
    final Widget _loginText =
    new Text('Login Information here '
        'function will be describe shortly');

    final Widget _loginCode = new Text('buttons_raised');

    List<ComponentTabData> components = <ComponentTabData>[
      new ComponentTabData(widget: buildLoginTab(),
          codeTag: _loginCode,
          description: _loginText,
          tabName: 'Login')
    ];
    return new TabbedComponentScaffold(
        components: components, title: 'Login', isMultiTab: false);
  }

  Widget buildLoginTab() {
    return new Align(
      alignment: const FractionalOffset(0.5, 0.4),
      child: new ButtonBar(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          new RaisedButton(
            child: const Text('Back'),
            onPressed: () {
              // Perform some action
            },
          ),
          const RaisedButton(
            child: const Text('Next'),
            onPressed: null,
          )
        ],
      ),
    );
  }
}
