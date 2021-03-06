import 'package:flutter/material.dart';

enum _MotradisMenuItem {
  signUp,
  signIn /*, calculateFee, traceTransfer, transferList, profil, costomerService, settings*/
}
enum MotradisHomeTab { send, receive, signInOrUp }

class _NotImplementedDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: const Text('Not Implemented'),
      content: const Text('This feature has not yet been implemented.'),
      actions: <Widget>[
        new FlatButton(
          onPressed: debugDumpApp,
          child: new Row(
            children: <Widget>[
              const Icon(
                Icons.dvr,
                size: 18.0,
              ),
              new Container(
                width: 8.0,
              ),
              const Text('DUMP APP TO CONSOLE'),
            ],
          ),
        ),
        new FlatButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text('OH WELL'),
        ),
      ],
    );
  }
}

class MotradisHome extends StatefulWidget {

  const MotradisHome(this.symbols);

  final List<String> symbols;

  @override
  MotradisHomeState createState() => new MotradisHomeState();
}

class MotradisHomeState extends State<MotradisHome> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _autorefresh = false;

  void _handleTransferMenu(BuildContext context, _MotradisMenuItem value) {
    switch (value) {
      case _MotradisMenuItem.signUp:
        showDialog<Null>(
            context: context,
            child: new _NotImplementedDialog()
        );
        break;
      case _MotradisMenuItem.signIn:
        showDialog<Null>(
            context: context,
            child: new _NotImplementedDialog()
        );
        break;
    }
  }

  Widget _buildDrawer(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          const DrawerHeader(child: const Center(child: const Text('MoneyTransfair'))),
          const ListTile(
            title: const Text('Sign up'),
            selected: true,
          ),
          const ListTile(
            title: const Text('Sign in'),
            enabled: false,
          ),
          const Divider(),
          new ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: _handleShowSettings,
          ),
          new ListTile(
            leading: const Icon(Icons.help),
            title: const Text('About Us'),
            onTap: _handleShowAbout,
          ),
        ],
      ),
    );
  }

  void _handleShowAbout() {
    showAboutDialog(context: context);
  }

  void _handleShowSettings() {
    Navigator.popAndPushNamed(context, '/settings');
  }

  Widget buildAppBar() {
    return new AppBar(
      elevation: 0.0,
      title: new Text('MoneyTransfair'),
      actions: <Widget>[
        new PopupMenuButton<_MotradisMenuItem>(
          onSelected: (_MotradisMenuItem value) {
            _handleTransferMenu(context, value);
          },
          itemBuilder: (BuildContext context) =>
          <PopupMenuItem<_MotradisMenuItem>>[
            new CheckedPopupMenuItem<_MotradisMenuItem>(
              value: _MotradisMenuItem.signUp,
              checked: _autorefresh,
              child: const Text('Sign up'),
            ),
            const PopupMenuItem<_MotradisMenuItem>(
              value: _MotradisMenuItem.signIn,
              child: const Text('Sign in'),
            )
          ],
        ),
      ],
      bottom: new TabBar(
        tabs: <Widget>[
          new Tab(text: 'Send'),
          new Tab(text: 'Sign in/up'),
          new Tab(text: 'Receive'),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        key: _scaffoldKey,
        appBar: buildAppBar(),
        drawer: _buildDrawer(context),
        body: new TabBarView(
          children: <Widget>[
            new Tab(text: 'Send Liste Items'),
            new Tab(text: 'Sign-In'),
            new Tab(text: 'Receive List Items'),
          ],
        ),
      ),
    );
  }
}