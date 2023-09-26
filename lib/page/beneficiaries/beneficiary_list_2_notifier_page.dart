import 'package:mspmis/model/beneficiary_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show PaginatedDataTable;
import 'package:mspmis/helpers/DatabaseHelper.dart';

class BeneficiaryDataNotifier with ChangeNotifier {
  BeneficiaryDataNotifier() {
    fetchData();
  }

  List<BeneficiaryModel> get beneficiaryModel => _beneficiaryModel;
  String get paymentToDo => _paymentToDo;
  String get paymentToSync => _paymentToSync;
  String get paymentSync => _paymentSync;
  // SORT COLUMN INDEX...

  int get sortColumnIndex => _sortColumnIndex;

  set sortColumnIndex(int sortColumnIndex) {
    _sortColumnIndex = sortColumnIndex;
    notifyListeners();
  }

  // SORT ASCENDING....

  bool get sortAscending => _sortAscending;

  set sortAscending(bool sortAscending) {
    _sortAscending = sortAscending;
    notifyListeners();
  }

  int get rowsPerPage => _rowsPerPage;

  set rowsPerPage(int rowsPerPage) {
    _rowsPerPage = rowsPerPage;
    notifyListeners();
  }

  // -------------------------------------- INTERNALS --------------------------------------------

  var _beneficiaryModel = <BeneficiaryModel>[];
  String _paymentToDo;
  String _paymentToSync;
  String _paymentSync;
  String _searchValue;

  int _sortColumnIndex;
  bool _sortAscending = true;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  Future<void> fetchData() async {
    _beneficiaryModel = await DatabaseHelper.instance.fetchAllBeneficiaries();
    _paymentToDo = await DatabaseHelper.instance.queryTransactionToDo();
    _paymentToSync = await DatabaseHelper.instance.queryTransactionToSync();
    _paymentSync = await DatabaseHelper.instance.queryTransactionSync();
    notifyListeners();
  }
}
