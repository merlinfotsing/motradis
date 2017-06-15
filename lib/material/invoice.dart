// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:motradis/common/component_tab.dart';

const String _invoiceText =
    'Invoice Information here '
    'function will be describe shortly';

const String _invoiceCode = 'buttons_raised';

const String _recipientText = 'Receipient Information here '
    'function will be describe shortly';

const String _receipientCode = 'receipient Code';

const String _paymentText =
    'Paymenet Information here '
    'function will be describe shortly';

const String _paymentCode = 'payment methode';

const String _verificationText =
    'Verification Information here '
    'function will be describe shortly';

const String _verificationCode = 'Verification code';

class ButtonsDemo extends StatefulWidget {
  static const String routeName = '/material//send';

  @override
  _ButtonsDemoState createState() => new _ButtonsDemoState();
}

class _ButtonsDemoState extends State<ButtonsDemo> {
  @override
  Widget build(BuildContext context) {
    final List<ComponentTabData> components = <ComponentTabData>[
      new ComponentTabData(
        tabName: 'Invoice',
        description: _invoiceText,
        widget: buildInvoiceTab(),
        codeTag: _invoiceCode,
      ),
      new ComponentTabData(
        tabName: 'Recipient',
        description: _recipientText,
        widget: buildRecipientComponent(),
        codeTag: _receipientCode,
      ),
      new ComponentTabData(
        tabName: 'Payment',
        description: _paymentText,
        widget: buildPaymentComponent(),
        codeTag: _paymentCode,
      ),
      new ComponentTabData(
        tabName: 'Verification',
        description: _verificationText,
        widget: buildVerificationComponent(),
        codeTag: _verificationCode,
      )
    ];

    return new TabbedComponentScaffold(
      title: 'Send Money',
      components: components,
    );
  }

  Widget buildInvoiceTab() {
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

  Widget buildRecipientComponent() {
    return new Align(
      alignment: const FractionalOffset(0.5, 0.4),
      child: new ButtonBar(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new FlatButton(
            child: const Text('Back'),
            onPressed: () {
              // Perform some action
            },
          ),
          const FlatButton(
            child: const Text('Next'),
            onPressed: null,
          )
        ],
      ),
    );
  }

  // https://en.wikipedia.org/wiki/Free_Four
  String dropdown1Value = 'Free';
  String dropdown2Value;
  String dropdown3Value = 'Four';

  Widget buildPaymentComponent() {
    return new Padding(
      padding: const EdgeInsets.all(24.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new ListTile(
            title: const Text('Simple dropdown:'),
            trailing: new DropdownButton<String>(
              value: dropdown1Value,
              onChanged: (String newValue) {
                setState(() {
                  dropdown1Value = newValue;
                });
              },
              items: <String>['One', 'Two', 'Free', 'Four'].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          new ListTile(
            title: const Text('Dropdown with a hint:'),
            trailing: new DropdownButton<String>(
              value: dropdown2Value,
              hint: const Text('Choose'),
              onChanged: (String newValue) {
                setState(() {
                  dropdown2Value = newValue;
                });
              },
              items: <String>['One', 'Two', 'Free', 'Four'].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          new ListTile(
            title: const Text('Scrollable dropdown:'),
            trailing: new DropdownButton<String>(
              value: dropdown3Value,
              onChanged: (String newValue) {
                setState(() {
                  dropdown3Value = newValue;
                });
              },
              items: <String>[
                'One', 'Two', 'Free', 'Four', 'Can', 'I', 'Have', 'A', 'Little',
                'Bit', 'More', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten'
              ]
                  .map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              })
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  bool iconButtonToggle = false;

  Widget buildVerificationComponent() {
    return new Align(
      alignment: const FractionalOffset(0.5, 0.4),
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new IconButton(
            icon: const Icon(Icons.thumb_up),
            onPressed: () {
              setState(() => iconButtonToggle = !iconButtonToggle);
            },
            color: iconButtonToggle ? Theme
                .of(context)
                .primaryColor : null,
          ),
          const IconButton(
            icon: const Icon(Icons.thumb_up),
            onPressed: null,
          )
        ]
            .map((Widget button) =>
        new SizedBox(width: 64.0, height: 64.0, child: button))
            .toList(),
      ),
    );
  }

  Widget buildActionButton() {
    return new Align(
      alignment: const FractionalOffset(0.5, 0.4),
      child: new FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Perform some action
        },
      ),
    );
  }
}
