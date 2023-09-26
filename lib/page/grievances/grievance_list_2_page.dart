import 'package:another_flushbar/flushbar.dart';
import 'package:mspmis/utils/dataTable/custom_dialog.dart';
import 'package:mspmis/utils/dataTable/custom_paginated_datatable.dart';
import 'package:mspmis/utils/dataTable/custom_scaffold.dart';
import 'package:mspmis/page/grievances/grievance_history_2_notifier_page.dart';
import 'package:mspmis/model/grievance_history_detail_page.dart';
import 'package:mspmis/model/grievance_history_datatable.dart';
import 'package:flutter/material.dart';
import 'package:mspmis/helpers/DatabaseHelper.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class GrievanceHistoryPaginableDataTablePage extends StatelessWidget {
  const GrievanceHistoryPaginableDataTablePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    return CustomScaffold(
      showDrawer: true,
      enableDarkMode: true,
      titleText: "",
      child: ChangeNotifierProvider<GrievanceHistoryDataNotifier>(
        create: (_) => GrievanceHistoryDataNotifier(),
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
    final _provider = context.watch<GrievanceHistoryDataNotifier>();
    final _model = _provider.grievanceModel;

    if (_model.isEmpty) {
      return const SizedBox.shrink();
    }
    final _dtSource = GrievanceHistoryDataTableSource(
        onRowSelect: (index) => _showDetails(context, _model[index]),
        grievanceData: _model,
        context: context);

    void sendAllData() async {
      var mapData = new Map<String, dynamic>();
      mapData['api_key'] = '434792038709226';
      mapData['data'] = _model;

      String url = "http://197.241.42.179/api/grievance/confirmation";
      final http.Response response = await http.post(Uri.parse(url),
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
              .updateGrievanceById(_model[i]['id']);
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
    GrievanceHistoryDataTableSource _src,
    GrievanceHistoryDataNotifier _provider,
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
          label: Text('Site Plainte'),
          tooltip: 'Guichet',
          onSort: (colIndex, asc) {
            _sort<String>(
                (data) => data['guichet_id'], colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text('Status Plainte'),
          tooltip: 'Grievance Status',
          onSort: (colIndex, asc) {
            _sort<String>((data) => data['grievance_flag'], colIndex, asc, _src,
                _provider);
          },
        ),
        DataColumn(
          label: Text('Status Sync'),
          tooltip: 'Synchronization Status',
          onSort: (colIndex, asc) {
            _sort<String>((data) => data['grievance_sync_date'], colIndex, asc,
                _src, _provider);
          },
        ),
        DataColumn(
          label: Text(""),
          tooltip: '...',
        ),
      ];

  void _sort<T>(
    Comparable<T> Function(Map<String, dynamic> user) getField,
    int colIndex,
    bool asc,
    GrievanceHistoryDataTableSource _src,
    GrievanceHistoryDataNotifier _provider,
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
          child: GrievanceHistoryDetails(data: data),
        ),
      );
}
