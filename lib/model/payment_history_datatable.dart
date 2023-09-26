import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:nb_utils/nb_utils.dart';

import 'package:mspmis/helpers/DatabaseHelper.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

typedef OnRowSelect = void Function(int index);

class PaymentHistoryDataTableSource extends DataTableSource {
  PaymentHistoryDataTableSource({
    @required List<Map<String, dynamic>> transactionData,
    @required this.onRowSelect,
    @required BuildContext context,
  })  : _transactionData = transactionData,
        selectedList = [],
        _context = context,
        assert(transactionData != null);

  final List<Map<String, dynamic>> _transactionData;
  final List<Map<String, dynamic>> selectedList;
  final OnRowSelect onRowSelect;
  final BuildContext _context;

  onDeleteSelected() async {
    if (selectedList.isNotEmpty) {
      //selectedList = [];
    }
  }

  onSelectedRow(bool selected, Map<String, dynamic> data) async {
    if (selected) {
      this.selectedList.add(data);
    } else {
      this.selectedList.remove(data);
    }
  }

  bool onCheckRow(Map<String, dynamic> data) {
    bool isIn = false;
    for (int i = 0; i < selectedList.length; i++) {
      if (selectedList[i]['benefitbeneficiary_id'] ==
          data['benefitbeneficiary_id']) isIn = true;
    }

    return isIn;
  }

  void sendData(Map<String, dynamic> data) async {
    var mapData = new Map<String, dynamic>();
    mapData['api_key'] = '434792038709226';
    mapData['data'] = [data];
    String url = "http://197.241.42.179/api/payment/confirmation";
    print(selectedList);
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
     ).show(_context);

      //for (int i = 0; i < selectedList.length; i++) {
      int update = await DatabaseHelper.instance
          .updateTransactionById(data['benefitbeneficiary_id']);
      //}
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      Flushbar(
        title: "Synchronizarion Results",
        message: "Failed ",
        duration: Duration(seconds: 5),
      ).show(_context);
    }
  }

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index >= _transactionData.length) {
      return null;
    }
    final _transaction = _transactionData[index];

    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text(_transaction['name'].toString().toUpperCase(),
            style: secondaryTextStyle())),
        DataCell(Text(_transaction['siteLabel'].toString().toUpperCase(),
            style: secondaryTextStyle())),
        DataCell(badges.Badge(
          badgeColor: _transaction['new_benefit_flag'] == ""
              ? Colors.red
              : Colors.green,
          shape: badges.BadgeShape.square,
          //borderRadius: 20,
          toAnimate: false,
          badgeContent: Text(
              _transaction['new_benefit_flag'] == "1" ? " Paye " : "Non Paye",
              style: TextStyle(color: Colors.white)),
        )),
        DataCell(badges.Badge(
          badgeColor: _transaction['synchronization_date'] == ""
              ? Colors.red
              : Colors.green,
          shape: badges.BadgeShape.square,
          //borderRadius: 20,
          toAnimate: false,
          badgeContent: Text(
              _transaction['synchronization_date'] == ""
                  ? " No Synchronized "
                  : "Synchronized",
              style: TextStyle(color: Colors.white)),
        )),
        DataCell(_transaction['synchronization_date'] == ""
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    //icon: const Icon(Icons.remove_red_eye),
                    icon: const Icon(Icons.remove_red_eye,
                        color: Colors.blueAccent, size: 30),
                    onPressed: () => onRowSelect(index),
                  ),
                  IconButton(
                    icon: Icon(Icons.sync, color: Colors.blueAccent, size: 30),
                    onPressed: () {
                      sendData(_transaction);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.grey, size: 30),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_forever,
                        color: Colors.grey, size: 30),
                    onPressed: () {},
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    //icon: const Icon(Icons.remove_red_eye),
                    icon: const Icon(Icons.remove_red_eye,
                        color: Colors.blueAccent, size: 30),
                    onPressed: () => onRowSelect(index),
                  )
                ],
              ))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _transactionData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(
      Comparable<T> Function(Map<String, dynamic> d) getField, bool ascending) {
    _transactionData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
