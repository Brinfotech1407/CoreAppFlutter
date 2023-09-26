import 'package:mspmis/helpers/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/generated/i18n.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  String total_beneficiaries;
  String total_transactions;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: body(context));
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    String _total_benficiaries =
        await DatabaseHelper.instance.queryRowCount("espmis_beneficiaries");
    String _total_transactions =
        await DatabaseHelper.instance.queryRowCount("espmis_transactions");
    setState(() {
      total_beneficiaries = _total_benficiaries;
      total_transactions = _total_transactions;
    });
  }

  Widget body(BuildContext context) => Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: optionsWidget(context),
            ),
          ],
        ),
      );

  Widget optionsWidget(BuildContext context) => Table(
        children: [
          TableRow(children: [
            InkWell(
              child: _ItemOption(
                title: S.of(context).lbl_voucher_management,
                image: R.image.ic_scan_white,
                number: S.of(context).lbl_number_of_vouchers('0'),
                margin: EdgeInsets.only(right: 10, bottom: 40),
                isFocused: true,
              ),
              onTap: () {
                Navigator.of(context).pushNamed(RouterName.VOUCHERS_MENU);
              },
            ),
            InkWell(
              child: _ItemOption(
                title: S.of(context).lbl_payment_management,
                image: R.image.ic_payment_white,
                number: S
                    .of(context)
                    .lbl_number_payment_transaction(total_transactions),
                margin: EdgeInsets.only(left: 10, bottom: 40),
              ),
              onTap: () {
                //Navigator.of(context).pushNamed(RouterName.PAYMENTS_MENU);
              },
            ),
          ]),
          TableRow(children: [
            InkWell(
              child: _ItemOption(
                  title: S.of(context).lbl_grievance_management,
                  image: R.image.ic_grievances_white,
                  number: S.of(context).lbl_number_grievances('0'),
                  margin: EdgeInsets.only(right: 10, bottom: 40)),
              onTap: () {
                //Navigator.of(context).pushNamed(RouterName.GRIEVANCES_MENU);
              },
            ),
            InkWell(
              child: _ItemOption(
                  title: S.of(context).lbl_beneficiary_management,
                  image: R.image.ic_beneficiaries_white,
                  number: S
                      .of(context)
                      .lbl_number_beneficiaries(total_beneficiaries),
                  margin: EdgeInsets.only(left: 10, bottom: 40),
                  isFocused: true),
              onTap: () {
                Navigator.of(context).pushNamed(RouterName.FIND_BENEFICIARY);
              },
            ),
          ]),
          TableRow(children: [
            InkWell(
              child: _ItemOption(
                  title: S.of(context).lbl_productive_measures_management,
                  image: R.image.ic_productive_measures_white,
                  number: '',
                  margin: EdgeInsets.only(right: 10, bottom: 40),
                  isFocused: true),
              onTap: () {
                Navigator.of(context).pushNamed(RouterName.PRODUCTIVEMEASURE_MENU);
              },
            ),
            InkWell(
              child: _ItemOption(
                title: S.of(context).lbl_setup_management,
                image: R.image.ic_setup_white,
                number: S.of(context).lbl_number_setup('0'),
                margin: EdgeInsets.only(left: 10, bottom: 40),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(RouterName.LOADING);
              },
            ),
          ]),
        ],
      );

  @override
  bool get wantKeepAlive => true;
}

Widget _ItemOption(
        {String title,
        String image,
        String number,
        bool isFocused = false,
        EdgeInsets margin}) =>
    Container(
      margin: margin,
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: SvgPicture.asset(image),
            margin: EdgeInsets.only(top: 0,bottom: 40),
          ),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Container(
            child: Text(number,
                style: TextStyle(
                    color: Colors.black87.withAlpha(100), fontSize: 14)),
          )
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          gradient: LinearGradient(
              colors: isFocused
                  ? [
                      R.color.blue,
                      R.color.light_blue,
                    ]
                  : [
                      R.color.gray,
                      R.color.grey,
                    ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          boxShadow: [
            BoxShadow(
                color: R.color.dark_black.withAlpha(50),
                blurRadius: 15,
                spreadRadius: 0,
                offset: Offset(5, 10))
          ]),
    );
