
import 'package:another_flushbar/flushbar.dart';
import 'package:mspmis/model/beneficiary_model.dart';
import 'package:mspmis/page/beneficiaries/beneficiaries_list_detail_page.dart';
import 'package:mspmis/utils/dataTable/custom_dialog.dart';
import 'package:mspmis/utils/dataTable/custom_paginated_datatable.dart';
import 'package:mspmis/utils/dataTable/custom_scaffold.dart';
import 'package:mspmis/page/beneficiaries/beneficiary_list_2_notifier_page.dart';
import 'package:mspmis/model/payment_history_detail_page.dart';
import 'package:mspmis/model/beneficiary_datatable.dart';
import 'package:flutter/material.dart';
import 'package:mspmis/helpers/DatabaseHelper.dart';
import 'dart:convert';
// import 'package:flushbar/flushbar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class BeneficiaryPaginableDataTablePage extends StatelessWidget {
  const BeneficiaryPaginableDataTablePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    return CustomScaffold(
      showDrawer: true,
      isInAsyncCall: false,
      enableDarkMode: true,
      titleText: "",
      child: ChangeNotifierProvider<BeneficiaryDataNotifier>(
        create: (_) => BeneficiaryDataNotifier(),
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
    final _provider = context.watch<BeneficiaryDataNotifier>();
    final _model = _provider.beneficiaryModel;
    String _paymentToDo = _provider.paymentToDo;
    String _paymentToSync = _provider.paymentToSync;
    String _paymentSync = _provider.paymentSync;

    if (_model.isEmpty) {
      return const SizedBox.shrink();
    }
    final _dtSource = BeneficiaryDataTableSource(
        onRowSelect: (index) => _showDetails(context, _model[index]),
        beneficiariesData: _model);

    return CustomPaginatedTable(
      actions: <IconButton>[
        IconButton(
          splashColor: Colors.transparent,
          icon: const Icon(Icons.search),
          onPressed: () {
            //_provider.fetchData();
            //_showSBar(context, "Liste", "Refreshed");
          },
        ),
        IconButton(
          splashColor: Colors.transparent,
          icon: const Icon(Icons.refresh),
          onPressed: () {
            _provider.fetchData();
            _showSBar(context, "Liste", "Refreshed");
          },
        ),
      ],
      dataColumns: _colGen(_dtSource, _provider),
      header: Column(
        children: <Widget>[
          /*
          Padding(
            padding: EdgeInsets.all(0),
            child: OutlineButton(
              child: Text(
                  '\u{2714} $_paymentSync  '), //Text('A SYNCHRONISER : $_paymentToSync'),
              onPressed: () {
                //sendAllData();
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(0),
            child: OutlineButton(
              child: Text(
                  '\u{2716} $_paymentToDo  '), //Text('A PAYER : $_paymentToDo'),
              onPressed: () {
                //sendAllData();
              },
            ),
          ),
          */
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
    BeneficiaryDataTableSource _src,
    BeneficiaryDataNotifier _provider,
  ) =>
      <DataColumn>[
        DataColumn(
          label: Text('Recipiendaire'),
          numeric: true,
          tooltip: 'Recipiendaire',
          onSort: (colIndex, asc) {
            _sort<String>((data) => data.name, colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text('ID Menage/Individu'),
          numeric: true,
          tooltip: 'Household/Individual ID',
        ),
        DataColumn(
          label: Text('Quartier'),
          numeric: true,
          tooltip: 'Ward',
          onSort: (colIndex, asc) {
            _sort<String>((data) => data.ward, colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text('TM 1'),
          numeric: true,
          tooltip: 'Payment/Voucher',
          onSort: (colIndex, asc) {
            _sort<String>((data) => data.transactions[0].transaction_status,
                colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text('TM 2'),
          numeric: true,
          tooltip: 'Payment/Voucher',
          onSort: (colIndex, asc) {
            _sort<String>((data) => data.transactions[1].transaction_status,
                colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text('TM 3'),
          numeric: true,
          tooltip: 'Payment/Voucher',
          onSort: (colIndex, asc) {
            _sort<String>((data) => data.transactions[2].transaction_status,
                colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text('TM 4'),
          numeric: true,
          tooltip: 'Payment/Voucher',
          onSort: (colIndex, asc) {
            _sort<String>((data) => data.transactions[3].transaction_status,
                colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text('TM 5'),
          numeric: true,
          tooltip: 'Payment/Voucher',
        ),
        DataColumn(
          label: Text('TM 6'),
          numeric: true,
          tooltip: 'Payment/Voucher',
        ),
        DataColumn(
          label: Text('TM 7'),
          numeric: true,
          tooltip: 'Payment/Voucher',
        ),
        DataColumn(
          label: Text('TM 8'),
          numeric: true,
          tooltip: 'Payment/Voucher',
        ),
        DataColumn(
          label: Text('TM 9'),
          numeric: true,
          tooltip: 'Payment/Voucher',
        ),
        DataColumn(
          label: Text('# Plaintes'),
          numeric: true,
          tooltip: 'Request/Complaint',
        ),
        DataColumn(
          label: Text("Action"),
          tooltip: '...',
        ),
      ];

  void _sort<T>(
    Comparable<T> Function(BeneficiaryModel user) getField,
    int colIndex,
    bool asc,
    BeneficiaryDataTableSource _src,
    BeneficiaryDataNotifier _provider,
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

  void _showDetails(BuildContext c, BeneficiaryModel data) async =>
      await showDialog<bool>(
        context: c,
        builder: (_) => CustomDialog(
          showPadding: false,
          child: BeneficiaryDetails(data: data),
        ),
      );
}
