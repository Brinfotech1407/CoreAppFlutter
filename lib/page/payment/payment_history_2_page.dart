import 'package:another_flushbar/flushbar.dart';
import 'package:mspmis/utils/dataTable/custom_dialog.dart';
import 'package:mspmis/utils/dataTable/custom_paginated_datatable.dart';
import 'package:mspmis/utils/dataTable/custom_scaffold.dart';
import 'package:mspmis/page/payment/payment_history_2_notifier_page.dart';
import 'package:mspmis/model/payment_history_detail_page.dart';
import 'package:mspmis/model/payment_history_datatable.dart';
import 'package:flutter/material.dart';
import 'package:mspmis/helpers/DatabaseHelper.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PaymentHistoryPaginableDataTablePage extends StatelessWidget {
  const PaymentHistoryPaginableDataTablePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    return CustomScaffold(
      isInAsyncCall: false,
      showDrawer: true,
      enableDarkMode: true,
      titleText: "",
      child: ChangeNotifierProvider<PaymentHistoryDataNotifier>(
        create: (_) => PaymentHistoryDataNotifier(),
        child: _InternalWidget(),
      ),
    );
  }
}

class _InternalWidget extends StatelessWidget {
  const _InternalWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final _provider = context.watch<PaymentHistoryDataNotifier>();
    final _model = _provider.transactionModel;

    if (_model.isEmpty) {
      return const SizedBox.shrink();
    }
    final _dtSource = PaymentHistoryDataTableSource(
        onRowSelect: (index) => _showDetails(context, _model[index]),
        transactionData: _model,
        context: context);

    void sendAllData() async {
      var mapData = new Map<String, dynamic>();
      mapData['api_key'] = '434792038709226';
      mapData['data'] = _model;
      String url = "http://197.241.42.179/api/payment/confirmation";
      final http.Response response =
          await http.post(Uri.parse(url),
              headers: {
                "Content-Type": "application/json",
                'Accept': 'application/json',
                'X-Force-Content-Type': 'application/json'
              },
              body: json.encode(mapData));
      print(response.body);
      if (response.statusCode == 200) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        Flushbar(
          title: json.decode(response.body)['msg'],
          message: json.decode(response.body)['details'],
          duration: Duration(seconds: 5),
        ).show(context);

        for (int i = 0; i < _model.length; i++) {
          int update = await DatabaseHelper.instance
              .updateTransactionById(_model[i]['benefitbeneficiary_id']);
        }
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        Flushbar(
          title: "Synchronizarion Results",
          message: "Failed ",
          duration: Duration(seconds: 5),
        ).show(context);
      }
    }

    return CustomPaginatedTable(
      actions: <IconButton>[
        IconButton(
          splashColor: Colors.transparent,
          icon: const Icon(Icons.refresh),
          onPressed: () {
            _provider.fetchData();
            _showSBar(context, "Transaction List", "Refreshed");
          },
        ),
      ],
      dataColumns: _colGen(_dtSource, _provider),
      header: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: OutlinedButton(
              child: Text('SEND ALL DATA'),
              onPressed: () {
                sendAllData();
              },
            ),
          ),
        ],
      ),
      onRowChanged: (index) => _provider.rowsPerPage = index,
      rowsPerPage: _provider.rowsPerPage,
      showActions: true,
      source: _dtSource,
      sortColumnIndex: _provider.sortColumnIndex,
      sortColumnAsc: _provider.sortAscending,
    );
  }

  List<DataColumn> _colGen(
    PaymentHistoryDataTableSource _src,
    PaymentHistoryDataNotifier _provider,
  ) =>
      <DataColumn>[
        DataColumn(
          label: Text('Recipiendaire'),
          numeric: true,
          tooltip: 'Recipiendaire',
          onSort: (colIndex, asc) {
            _sort<String>(
                (data) => data['name'], colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text('Site Paiement'),
          tooltip: 'Site',
          onSort: (colIndex, asc) {
            _sort<String>(
                (data) => data['site'], colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text('Status Paiement'),
          tooltip: 'Payment Status',
          onSort: (colIndex, asc) {
            _sort<String>((data) => data['new_benefit_flag'], colIndex, asc,
                _src, _provider);
          },
        ),
        DataColumn(
          label: Text('Status Sync'),
          tooltip: 'Synchronization Status',
          onSort: (colIndex, asc) {
            _sort<String>((data) => data['synchronization_date'], colIndex, asc,
                _src, _provider);
          },
        ),
        /*
        DataColumn(
          label: Text("Action"),
          tooltip: '...',
        ),*/
        DataColumn(
          label: Text(""),
          tooltip: '...',
        ),
      ];

  void _sort<T>(
    Comparable<T> Function(Map<String, dynamic> user) getField,
    int colIndex,
    bool asc,
    PaymentHistoryDataTableSource _src,
    PaymentHistoryDataNotifier _provider,
  ) {
    _src.sort<T>(getField, asc);
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }

  void _showSBar(BuildContext c, String titleToShow, String textToShow) {
    Flushbar(
      title: titleToShow,
      message: textToShow,
      duration: Duration(seconds: 5),
    ).show(c);

  }

  void _showDetails(BuildContext c, Map<String, dynamic> data) async =>
      await showDialog<bool>(
        context: c,
        builder: (_) => CustomDialog(
          showPadding: false,
          child: PaymentHistoryDetails(data: data),
        ),
      );
}
