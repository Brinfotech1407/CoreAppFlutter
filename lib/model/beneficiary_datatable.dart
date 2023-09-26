import 'package:mspmis/model/beneficiary_model.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:nb_utils/nb_utils.dart';


// import 'package:flushbar/flushbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

typedef OnRowSelect = void Function(int index);

class BeneficiaryDataTableSource extends DataTableSource {
  BeneficiaryDataTableSource({
    @required List<BeneficiaryModel> beneficiariesData,
    @required this.onRowSelect,
  })  : _beneficiariesData = beneficiariesData,
        selectedList = [],
        assert(beneficiariesData != null);

  final List<BeneficiaryModel> _beneficiariesData;
  final List<BeneficiaryModel> selectedList;
  final OnRowSelect onRowSelect;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index >= _beneficiariesData.length) {
      return null;
    }
    final _beneficiary = _beneficiariesData[index];

    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text(_beneficiary.name.toString().toUpperCase(),
            style: secondaryTextStyle())),
        DataCell(Text(
            _beneficiary.householdid + "/" + _beneficiary.individualid,
            style: secondaryTextStyle())),
        DataCell(Text(_beneficiary.ward, style: secondaryTextStyle())),
        DataCell(_beneficiary.transactions.length < 1
            ? Text("")
            : badges.Badge(
                badgeColor: checkColorTransactionStatus(
                    _beneficiary.transactions[0].transaction_new_status,
                    _beneficiary.transactions[0].transaction_status),
                shape: badges.BadgeShape.square,
                //borderRadius: 20,
                toAnimate: false,
                badgeContent: Text(
                    checkLabelTransactionStatus(
                        _beneficiary.transactions[0].transaction_new_status,
                        _beneficiary.transactions[0].transaction_status),
                    style: TextStyle(color: Colors.white)),
              )),
        DataCell(_beneficiary.transactions.length < 2
            ? Text("")
            : badges.Badge(
                badgeColor: checkColorTransactionStatus(
                    _beneficiary.transactions[1].transaction_new_status,
                    _beneficiary.transactions[1].transaction_status),
                shape: badges.BadgeShape.square,
                //borderRadius: 20,
                toAnimate: false,
                badgeContent: Text(
                    checkLabelTransactionStatus(
                        _beneficiary.transactions[1].transaction_new_status,
                        _beneficiary.transactions[1].transaction_status),
                    style: TextStyle(color: Colors.white)),
              )),
        DataCell(_beneficiary.transactions.length < 3
            ? Text("")
            : badges.Badge(
                badgeColor: checkColorTransactionStatus(
                    _beneficiary.transactions[2].transaction_new_status,
                    _beneficiary.transactions[2].transaction_status),
                shape: badges.BadgeShape.square,
                //borderRadius: 20,
                toAnimate: false,
                badgeContent: Text(
                    checkLabelTransactionStatus(
                        _beneficiary.transactions[2].transaction_new_status,
                        _beneficiary.transactions[2].transaction_status),
                    style: TextStyle(color: Colors.white)),
              )),
        DataCell(_beneficiary.transactions.length < 4
            ? Text("")
            : badges.Badge(
                badgeColor: checkColorTransactionStatus(
                    _beneficiary.transactions[3].transaction_new_status,
                    _beneficiary.transactions[3].transaction_status),
                shape: badges.BadgeShape.square,
                //borderRadius: 20,
                toAnimate: false,
                badgeContent: Text(
                    checkLabelTransactionStatus(
                        _beneficiary.transactions[3].transaction_new_status,
                        _beneficiary.transactions[3].transaction_status),
                    style: TextStyle(color: Colors.white)),
              )),
        DataCell(_beneficiary.transactions.length < 5
            ? Text("")
            : badges.Badge(
                badgeColor: checkColorTransactionStatus(
                    _beneficiary.transactions[4].transaction_new_status,
                    _beneficiary.transactions[4].transaction_status),
                shape: badges.BadgeShape.square,
                //borderRadius: 20,
                toAnimate: false,
                badgeContent: Text(
                    checkLabelTransactionStatus(
                        _beneficiary.transactions[4].transaction_new_status,
                        _beneficiary.transactions[4].transaction_status),
                    style: TextStyle(color: Colors.white)),
              )),
        DataCell(_beneficiary.transactions.length < 6
            ? Text("")
            : badges.Badge(
                badgeColor: checkColorTransactionStatus(
                    _beneficiary.transactions[5].transaction_new_status,
                    _beneficiary.transactions[5].transaction_status),
                shape: badges.BadgeShape.square,
                //borderRadius: 20,
                toAnimate: false,
                badgeContent: Text(
                    checkLabelTransactionStatus(
                        _beneficiary.transactions[5].transaction_new_status,
                        _beneficiary.transactions[5].transaction_status),
                    style: TextStyle(color: Colors.white)),
              )),
        DataCell(_beneficiary.transactions.length < 7
            ? Text("")
            : badges.Badge(
                badgeColor: checkColorTransactionStatus(
                    _beneficiary.transactions[6].transaction_new_status,
                    _beneficiary.transactions[6].transaction_status),
                shape: badges.BadgeShape.square,
                //borderRadius: 20,
                toAnimate: false,
                badgeContent: Text(
                    checkLabelTransactionStatus(
                        _beneficiary.transactions[6].transaction_new_status,
                        _beneficiary.transactions[6].transaction_status),
                    style: TextStyle(color: Colors.white)),
              )),
        DataCell(_beneficiary.transactions.length < 8
            ? Text("")
            : badges.Badge(
                badgeColor: checkColorTransactionStatus(
                    _beneficiary.transactions[7].transaction_new_status,
                    _beneficiary.transactions[7].transaction_status),
                shape: badges.BadgeShape.square,
                //borderRadius: 20,
                toAnimate: false,
                badgeContent: Text(
                    checkLabelTransactionStatus(
                        _beneficiary.transactions[7].transaction_new_status,
                        _beneficiary.transactions[7].transaction_status),
                    style: TextStyle(color: Colors.white)),
              )),
        DataCell(_beneficiary.transactions.length < 9
            ? Text("")
            : badges.Badge(
                badgeColor: checkColorTransactionStatus(
                    _beneficiary.transactions[8].transaction_new_status,
                    _beneficiary.transactions[8].transaction_status),
                shape: badges.BadgeShape.square,
                //borderRadius: 20,
                toAnimate: false,
                badgeContent: Text(
                    checkLabelTransactionStatus(
                        _beneficiary.transactions[8].transaction_new_status,
                        _beneficiary.transactions[8].transaction_status),
                    style: TextStyle(color: Colors.white)),
              )),
        DataCell(Text(
            _beneficiary.grievances == null
                ? '0'
                : _beneficiary.grievances.length.toString(),
            style: secondaryTextStyle())),
        DataCell(Row(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              icon: Icon(Icons.sync, color: Colors.grey, size: 30),
              onPressed: () {
                //sendData(_transaction);
              },
            ),
            IconButton(
              icon: Icon(Icons.edit, color: Colors.grey, size: 30),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.delete_forever, color: Colors.grey, size: 30),
              onPressed: () {},
            ),
          ],
        ))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _beneficiariesData.length;

  @override
  int get selectedRowCount => 0;

  Color checkColorTransactionStatus(
      String transaction_new_satus, String transaction_status) {
    if (transaction_new_satus == "" && transaction_status != "1") {
      if (transaction_status == "2")
        return Colors.red;
      else
        return Colors.orange;
    } else
      return Colors.green;
  }

  String checkLabelTransactionStatus(
      String transaction_new_satus, String transaction_status) {
    if (transaction_new_satus == "" && transaction_status != "1") {
      if (transaction_status == "2")
        return " Non Payee ";
      else
        return " Annulee ";
    } else
      return " Payee ";
  }

  void sort<T>(
      Comparable<T> Function(BeneficiaryModel d) getField, bool ascending) {
    _beneficiariesData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
