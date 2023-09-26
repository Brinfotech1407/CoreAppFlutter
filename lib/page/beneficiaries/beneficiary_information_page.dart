import 'package:mspmis/model/beneficiary_model.dart';
import 'package:flutter/material.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/generated/i18n.dart';
import 'package:mspmis/utils/utils.dart';

class InformationBeneficiaryPage extends StatefulWidget {

  InformationBeneficiaryPage({Key key, this.beneficiary}) : super(key: key);
  final BeneficiaryModel beneficiary;

  @override
  _InformationBeneficiaryPageState createState() {
  return _InformationBeneficiaryPageState();
  }
  }

  class _InformationBeneficiaryPageState extends State<InformationBeneficiaryPage> {
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
              _InforWidget(
                  title: S.of(context).lbl_address_timing,
                  content:
                  "Quartier : " + widget.beneficiary.ward + "\n" + "Localite / Arrondissement : " + widget.beneficiary.constituency + "\n" + "Commune / (Ss) Prefecture : " + widget.beneficiary.county + "\n" + "Region : " + widget.beneficiary.district
              ),
              _InforWidget(
                  title: S.of(context).lbl_phone,
                  content: ""),
              _InforWidget(
                  title: S.of(context).lbl_certificate, content: "")
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
