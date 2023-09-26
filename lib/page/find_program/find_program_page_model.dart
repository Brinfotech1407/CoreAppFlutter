import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';

class FindProgramPageModel extends ChangeNotifier {
  Map data;
  int programSelected ;

  FindProgramPageModel();

  void updateData(int value) {
    data['_program'] = value;
  }

  void updateProgram(int value) {
    programSelected = value;
    notifyListeners();
  }
}
