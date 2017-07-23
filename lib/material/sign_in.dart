import 'package:flutter/material.dart';
import 'package:motradis/common/app_theme.dart';
import 'package:motradis/common/component_tab.dart';

class SignIn extends StatefulWidget {

  static const String routeName = '/material//login';

  @override
  _SignInState createState() => new _SignInState();
}

class User {
  String email;
  String password;
  bool showPassword = false;
  bool rememberEmail = true;
}


class _SignInState extends State<SignIn> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _passwordFieldKey = new GlobalKey<
      FormFieldState>();
  bool _autovalidate = false;
  User user = new User();
  bool switchValue = false;

  bool _formWasEdited = false;

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }

  void _handleSubmitted() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true; // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      showInSnackBar('${user.email}\'s e-mail is ${user.email}');
    }
  }

  String _validateEmail(String value) {
    _formWasEdited = true;
    if (value.isEmpty)
      return 'E-Mail is required.';
    final RegExp emailExp = new RegExp(
        r'^([\w-\\.]+)@((?:[\w]+\.)+)([a-zA-Z]){2,4}$');
    if (!emailExp.hasMatch(value))
      return 'Please enter a valid e-mail adresse';
    return null;
  }

  String _validatePassword(String value) {
    _formWasEdited = true;
    if (value.isEmpty)
      return 'E-Mail is required.';
    final RegExp emailExp = new RegExp(
        r'^([\w-\\.]+)@((?:[\w]+\.)+)([a-zA-Z]){2,4}$');
    if (!emailExp.hasMatch(value))
      return 'Please enter a valid e-mail adresse';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Widget _loginText = new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.lock),
          new Padding(
              padding: const EdgeInsets.all(5.0),
              child: new Text(
                'secured login',
                textAlign: TextAlign.center,
              )
          )
        ]);

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

  bool _obscureTextField() {
    return !user.showPassword;
  }

  String _getPasswordObscureText() {
    return _obscureTextField()
        ? 'SHOW'
        : 'HIDE';
  }

  final TextEditingController _textController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget buildLoginTab() {
    final AppTheme appTheme = AppTheme.of(context);
    return new Form(
        key: _formKey,
        autovalidate: _autovalidate,
        child: new ListView(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                  color: appTheme.cardBackgroundColor),
              child: new IconTheme(
                  data: new IconThemeData(
                      color: Theme
                          .of(context)
                          .accentColor),
                  child: new Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: new Row(
                        children: <Widget>[
                          new Flexible(
                            child: new TextFormField(
                              controller: _textController,
                              decoration: const InputDecoration(
                                  hintText: 'please enter your e-mail',
                                  labelText: 'E-Mail',
                                hideDivider: true,
                              ),
                              onSaved: (String value) {
                                user.email = value;
                                setState(() {
                                  _formKey.currentState.setState(() {
                                    user.email = value;
                                  });
                                });
                              },
                              //validator: _validateEmail,
                            ),
                          ),
                          new Container(
                            margin: const EdgeInsets.only(left: 20.0),
                            alignment: const FractionalOffset(0.5, 0.5),
                            child: new IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _textController.clear();
                              },
                            ),
                          ),
                        ]
                    ),
                  )
              ),
            ),
            new Container(
              decoration: new BoxDecoration(
                  color: appTheme.cardBackgroundColor),
              child: new IconTheme(
                  data: new IconThemeData(color: Theme
                      .of(context)
                      .accentColor),
                  child: new Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: new Row(
                        children: <Widget>[
                          new Flexible(
                            key: _passwordFieldKey,
                            child: new TextFormField(
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                  hintText: 'please enter a password',
                                  labelText: 'Password',
                                  hideDivider: true
                              ),
                              obscureText: _obscureTextField(),
                              onSaved: (String value) {
                                user.password = value;
                                setState(() {

                                });
                              },
                              // validator: _validatePassword,
                            ),
                          ),
                          new Center(
                              child: new FlatButton(
                                  onPressed: () => _changeShowPassword(),
                                  child: new Text(_getPasswordObscureText(), style: const TextStyle(
                                    color: const Color(0xFF42A5F5),
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                  ))
                              )
                          ),
                        ]
                    ),
                  )
              ),
            ),
            const Divider(height: 1.0),
            new Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Container(
                          margin: const EdgeInsets.only(right: 8.0),
                          child: new FlatButton(
                              onPressed: () {
                                Navigator.of(context).maybePop();
                              },
                              child: const Text(
                                  'CANCEL', style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500
                              ))
                          )
                      ),
                      new Container(
                          margin: const EdgeInsets.only(right: 8.0),
                          child: new FlatButton(
                              onPressed: () {
                                setState(() {
                                  String username = user.email;
                                  String password = user.password;
                                  _formKey.currentState.setState(() {
                                    //user.email = value;
                                  });
                                });
                                //  Form.of(context).save();
                              },
                              child: const Text('SEND', style: const TextStyle(
                                  color: const Color(0xFF42A5F5),
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500
                              ))
                          )
                      )
                    ]
                )
            )
          ],
        )
    );
  }

  _changeShowPassword() {
    user.showPassword = !user.showPassword;
  }
}