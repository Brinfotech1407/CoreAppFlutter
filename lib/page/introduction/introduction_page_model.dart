import 'package:flutter/material.dart';

class IntroductionPageModel extends ChangeNotifier {
  int currentPage = 0;

  void updatePage(int page) {
    currentPage = page;
    notifyListeners();
  }
}
