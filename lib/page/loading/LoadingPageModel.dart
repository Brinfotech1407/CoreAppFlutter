import 'package:flutter/material.dart';

class LoadingPageModel extends ChangeNotifier {

  int _program ;
  int _project ;
  int _phase ;
  int _district;
  int _site ;

  Map get data => {
    "_program": _program,
    "_project": _project,
    "_phase": _phase,
    "_district": _district,
    "_site": _site
  };
}