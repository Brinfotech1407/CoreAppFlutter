import 'package:mspmis/helpers/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:mspmis/model/beneficiary_model.dart';

class BeneficiariesListPageModel extends ChangeNotifier {
  BeneficiariesListPageModel();

  List<BeneficiaryModel> _newBeneficiaries = List<BeneficiaryModel>();
  bool _isFetching = false;

  void setBeneficiariesList(List<BeneficiaryModel> data) {
    _newBeneficiaries = data;
    notifyListeners();
  }

  List<BeneficiaryModel> get getBeneficiariesList => _newBeneficiaries;

  bool get isFetching => _isFetching;

  Future<void> fetchData() async {
    _isFetching = true;
    notifyListeners();



    _isFetching = false;
    notifyListeners();
  }

  Future<void> fetchLocalData() async {
    _isFetching = true;
    notifyListeners();

    DatabaseHelper.instance
        .fetchAllBeneficiaries()
        .then((data) => {setBeneficiariesList(data)});

    _isFetching = false;
    notifyListeners();
  }

  void removeAt(int index) {
    _newBeneficiaries.removeAt(index);
    notifyListeners();
  }
}
