import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/generated/i18n.dart';
import 'package:mspmis/utils/utils.dart';
import 'package:mspmis/helpers/DatabaseHelper.dart';

class BeneficiariesHomePage extends StatefulWidget {
  @override
  _BeneficiariesHomePageState createState() {
    return _BeneficiariesHomePageState();
  }
}

class _BeneficiariesHomePageState extends State<BeneficiariesHomePage>
    with AutomaticKeepAliveClientMixin<BeneficiariesHomePage> {
  String total_beneficiaries;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    String _total_benficiaries =
        await DatabaseHelper.instance.queryRowCount("espmis_beneficiaries");

    setState(() {
      total_beneficiaries = _total_benficiaries;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MainAppBar(
          context: context,
          leading: ButtonBackWhite(context),
          title:
              TitleAppBarWhite(title: S.of(context).title_module_beneficiaries),
        ),
        body: body(context));
  }

  Widget body(BuildContext context) => Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[optionsWidget(context)],
        ),
      );

  Widget optionsWidget(BuildContext context) => Table(
        children: [
          TableRow(children: [
            InkWell(
              child: _ItemOption(
                  title: S.of(context).lbl_find_beneficiary,
                  image: R.image.ic_search,
                  number: S
                      .of(context)
                      .lbl_number_beneficiaries(total_beneficiaries),
                  margin: EdgeInsets.only(left: 10, bottom: 40),
                  isFocused: true),
              onTap: () {
                Navigator.of(context).pushNamed(RouterName.FIND_BENEFICIARY);
              },
            ),
            InkWell(
              child: _ItemOption(
                title: S.of(context).lbl_add_grievance,
                image: R.image.ic_grievances_white,
                number: S.of(context).lbl_number_grievances('0'),
                margin: EdgeInsets.only(left: 10, bottom: 40),
              ),
              onTap: () {},
            ),
          ]),
          TableRow(children: [
            InkWell(
              child: _ItemOption(
                title: S.of(context).lbl_add_payment,
                image: R.image.ic_payment_white,
                number: S.of(context).lbl_number_payment_transaction('0'),
                margin: EdgeInsets.only(left: 10, bottom: 40),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(RouterName.FIND_BENEFICIARY);
              },
            ),
            InkWell(
              child: _ItemOption(
                title: S.of(context).lbl_add_beneficiary,
                image: R.image.ic_beneficiaries_white,
                number: S.of(context).lbl_number_beneficiaries('0'),
                margin: EdgeInsets.only(left: 10, bottom: 40),
              ),
              onTap: () {},
            )
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
            margin: EdgeInsets.only(bottom: 40),
          ),
          Text(
            title,
            maxLines: 1,
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
