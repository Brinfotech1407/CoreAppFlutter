import 'package:mspmis/model/productive_measure_model.dart';
import 'package:flutter/material.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/generated/i18n.dart';
import 'package:mspmis/utils/utils.dart';

class InformationGroupementPage extends StatefulWidget {

  InformationGroupementPage({Key key, this.groupement}) : super(key: key);
  final GroupementModel groupement;

  @override
  _InformationGroupementPageState createState() {
  return _InformationGroupementPageState();
  }
  }

  class _InformationGroupementPageState extends State<InformationGroupementPage> {
  bool isSearching = false;
  FocusNode _focusSearch = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
          context: context,
          title:
          TitleAppBarWhite(title: S.of(context).title_information_beneficiary),
          leading: ButtonBackWhite(context)),
      body: Container(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _InforWidget(
                  title: S.of(context).lbl_about,
                  content:
                  ""),

            ],
          ),
        ),
      ),
    );
  }
}

Widget _InforWidget({String title, String content}) => Container(
  decoration: ShadowDecorationWhite(),
  margin: EdgeInsets.only(bottom: 30),
  width: double.infinity,
  padding: EdgeInsets.all(20),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      Text(
        title,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: R.color.black),
      ),
      Container(
        margin: EdgeInsets.only(top: 10),
        child: Text(
          content,
          style: TextStyle(fontSize: 14, color: R.color.dark_black),
        ),
      )
    ],
  ),
);
