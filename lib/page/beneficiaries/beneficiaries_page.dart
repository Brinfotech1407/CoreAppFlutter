// #4e6ce3
import 'package:mspmis/page/beneficiaries/beneficiaries_grievance_page.dart';
import 'package:mspmis/page/beneficiaries/beneficiaries_productivemeasure_page.dart';
import 'package:mspmis/page/payment/payment_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mspmis/generated/i18n.dart';
import 'package:mspmis/utils/utils.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/model/beneficiary_model.dart';
import 'package:mspmis/page/beneficiaries/beneficiaries_payment_page.dart';
import 'package:mspmis/page/beneficiaries/beneficiary_information_page.dart';
import 'dart:convert';
import 'package:mspmis/helpers/DatabaseHelper.dart';
import 'package:mspmis/generated/i18n.dart';

class BeneficiariesPage extends StatefulWidget {
  BeneficiariesPage({Key key, this.beneficiary}) : super(key: key);
  final BeneficiaryModel beneficiary;

  @override
  _BeneficiariesPageState createState() {
    return _BeneficiariesPageState();
  }
}

class _BeneficiariesPageState extends State<BeneficiariesPage> {
  bool _isChecked;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    List<TransactionModel> result = await DatabaseHelper.instance
        .fetchTransactionNotPaid(widget.beneficiary.id);

    setState(() {
      if (result == null)
        _isChecked = false;
      else
        _isChecked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
          context: context,
          title:
              TitleAppBarWhite(title: S.of(context).title_beneficiary_profile),
          leading: ButtonBackWhite(context)),
      body: Container(
        padding: EdgeInsets.only(top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 30, bottom:30),
              child: Row(
                //mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomCircleAvatar(
                      size: 120,
                      child: widget.beneficiary.photo == null
                          ? Image.asset(R.image.avatar)
                          : new Image.memory(
                              base64Decode(widget.beneficiary.photo.substring(23)))),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 0, bottom:5),
              child: Text(
                widget.beneficiary.name.toUpperCase(),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: R.color.black),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 0),
              child: Text(
                S.of(context).lbl_householdid(widget.beneficiary.householdid),
                style: TextStyle(color: R.color.grey, fontSize: 16),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    S
                        .of(context)
                        .lbl_individualid(widget.beneficiary.individualid),
                    style: TextStyle(color: R.color.grey, fontSize: 16),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton.extended(
                      heroTag: '4',
                      label: Text(
                        S.of(context).btn_scan.toUpperCase(),
                        style: TextStyle(color: R.color.white, fontSize: 12),
                      ),
                      backgroundColor: R.color.blue,
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _isChecked == false
                            ? showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    SimpleDialogExample(),
                              )
                            : Navigator.of(context)
                                .pushNamed(RouterName.SCAN_BARCODE);
                      }),
                  FloatingActionButton.extended(
                      heroTag: '5',
                      label: Text(
                        S.of(context).btn_add_payment.toUpperCase(),
                        style: TextStyle(color: R.color.white, fontSize: 12),
                      ),
                      backgroundColor: R.color.blue,
                      icon: Icon(
                        Icons.monetization_on,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _isChecked == true
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PaymentDetailPage(barcode: [
                                    widget.beneficiary.id.toString(),
                                    widget.beneficiary.householdid,
                                    widget.beneficiary.individualid
                                  ], type_result: 'FIND'),
                                ),
                              )
                            : showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    SimpleDialogExample(),
                              );
                      }),
                  FloatingActionButton.extended(
                      heroTag: '6',
                      label: Text(
                        S.of(context).btn_add_grievance.toUpperCase(),
                        style: TextStyle(color: R.color.white, fontSize: 12),
                      ),
                      backgroundColor: R.color.blue,
                      icon: Icon(
                        Icons.add_comment,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(

                          ),
                        );
                      }),
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _ButtonDetail(
                      image: SvgPicture.asset(
                          R.image.ic_tabbar_beneficiaries_blue),
                      text: S.of(context).lbl_personal_information,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InformationBeneficiaryPage(
                                beneficiary: widget.beneficiary),
                          ),
                        );
                      }),
                  _ButtonDetail(
                      image:
                          SvgPicture.asset(R.image.ic_tabbar_addpayment_blue),
                      text: S.of(context).lbl_beneficiary_payment_transaction,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BenefciariesPaymentPage(
                                beneficiary: widget.beneficiary),
                          ),
                        );
                      }),
                  _ButtonDetail(
                      image:
                          SvgPicture.asset(R.image.ic_tabbar_addproductivemeasure_blue),
                      text: S.of(context).lbl_beneficiary_productivemeasure_transaction,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BenefciariesProductiveMeasurePage(
                                beneficiary: widget.beneficiary),
                          ),
                        );
                      }),
                  _ButtonDetail(
                      image:
                      SvgPicture.asset(R.image.ic_tabbar_addgrievance_blue),
                      text: S.of(context).lbl_beneficiary_grievance_transaction,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BenefciariesGrievancePage(
                                beneficiary: widget.beneficiary),
                          ),
                        );
                      }),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget _ButtonDetail({Widget image, String text, Function onTap}) => InkWell(
        onTap: onTap,
        child: Container(
          decoration: ShadowDecorationWhite(),
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 32),
          padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
          child: Row(
            children: <Widget>[
              image,
              Container(
                margin: EdgeInsets.only(left: 25, right: 25),
                width: 1,
                height: 30,
                color: R.color.dark_white,
              ),
              Expanded(
                  child: Text(
                text,
                style: TextStyle(color: R.color.black, fontSize: 18),
              )),
              Container(
                child: SvgPicture.asset(R.image.ic_arrow_right),
              )
            ],
          ),
        ),
      );
}
