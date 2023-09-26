import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show PaginatedDataTable;
import 'package:mspmis/helpers/DatabaseHelper.dart';

class PaymentHistoryDataNotifier with ChangeNotifier {
  PaymentHistoryDataNotifier() {
    fetchData();
  }

  List<Map<String, dynamic>> get transactionModel => _transactionModel;

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

  var _transactionModel = <Map<String, dynamic>>[];

  int _sortColumnIndex;
  bool _sortAscending = true;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  Future<void> fetchData() async {
    _transactionModel =
        await DatabaseHelper.instance.fetchTransactionsToBeSync();

    notifyListeners();
  }
}
