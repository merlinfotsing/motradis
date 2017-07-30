// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:motradis/common/component_tab.dart';

Widget _invoiceText =
new Text('Invoice Information here \n'
    'functionality is up to come');

Widget _invoiceCode = new Text('buttons_raised');

Widget _recipientText =
new Text('Receipient Information here \n'
    'functionality is up to come');

Widget _receipientCode = new Text('receipient Code');

Widget _paymentText = new Text(
    'Paymenet Information here \n'
        'functionality is up to come');

Widget _paymentCode = new Text('payment methode');

Widget _verificationText = new Text(
    'Verification Information here \n'
        'functionality is up to come');

Widget _verificationCode = new Text('Verification code');

class InvoiceWidget extends StatefulWidget {
  static const String routeName = '/material//invoice';

  @override
  _InvoiceWidgetState createState() => new _InvoiceWidgetState();
}

class _InvoiceWidgetState extends State<InvoiceWidget> with SingleTickerProviderStateMixin {

  /// This controller can be used to programmatically
  /// set the current displayed page
  TabController controller;

  /// Indicating the current displayed page
  /// 0: Invoice
  /// 1: Recipient
  /// 2: Payment
  /// 3: Verification
  int _pageInvoice = 0;
  int _pageRecipient = 1;
  int _pagePayment = 2;
  int _pageVerification = 3;


  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    if (controller != null) {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<ComponentTabData> components = <ComponentTabData>[
      new ComponentTabData(
        tabName: 'Invoice',
        description: _invoiceText,
        widget: buildInvoiceTab(),
          codeTag: _invoiceCode
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
      isMultiTab: true,
      controller: controller,
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
              Navigator.of(context).maybePop();
            },
          ),
          new RaisedButton(
            child: const Text('Next'),
            onPressed: () {
              controller.animateTo(_pageRecipient, duration: const Duration(milliseconds: 300), curve: Curves.ease);
            },
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
          new RaisedButton(
            child: const Text('Back'),
            onPressed: () {
              controller.animateTo(_pageInvoice, duration: const Duration(milliseconds: 300), curve: Curves.ease);
            },
          ),
          new RaisedButton(
            child: const Text('Next'),
            onPressed: () {
              controller.animateTo(_pagePayment, duration: const Duration(milliseconds: 300), curve: Curves.ease);
            },
          )
        ],
      ),
    );
  }

  Widget buildPaymentComponent() {
    return new Padding(
      padding: const EdgeInsets.all(24.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[],
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
