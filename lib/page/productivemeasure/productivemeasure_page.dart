
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/generated/i18n.dart';
import 'package:mspmis/helpers/DatabaseHelper.dart';


import 'package:mspmis/utils/utils.dart';

class ProductiveMeasurePage extends StatefulWidget {
  @override
  _ProductiveMeasurePageState createState() {
    return _ProductiveMeasurePageState();
  }
}

class _ProductiveMeasurePageState extends State<ProductiveMeasurePage>
    with AutomaticKeepAliveClientMixin<ProductiveMeasurePage> {
  String total_groupements;
  String total_subventions;
  String total_productivesactivities;

  @override
  void initState() {
    super.initState();
    init();
  }
  init() async {
    String _total_groupements =
    await DatabaseHelper.instance.queryRowCount("espmis_groupements");
    String _total_subventions =
    await DatabaseHelper.instance.queryRowCount("espmis_grants");
    String _total_productivesactivities =
    await DatabaseHelper.instance.queryRowCount("espmis_productives_activities");

    setState(() {
      total_groupements = _total_groupements;
      total_subventions = _total_subventions;
      total_productivesactivities = _total_productivesactivities;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MainAppBar(
          context: context,
          leading: ButtonBackWhite(context),
          title: TitleAppBarWhite(title: S.of(context).title_beneficairies_productivemeasure),
        ),
        body: body(context));
  }

  Widget body(BuildContext context) => Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
          child: null



            ),
            Container(
          child:null,



              margin: EdgeInsets.only(top: 10, bottom: 40, left: 20, right: 20),
            ),
            optionsWidget(context)
          ],
        ),
      );

  Widget optionsWidget(BuildContext context) => Table(
        children: [
          TableRow(children: [
            InkWell(
              child: _ItemOption(
                title: S.of(context).lbl_groupement_ip,
                image: R.image.ic_groupement_white,
                number: S.of(context).lbl_number_groupement_ip(total_groupements),
                margin: EdgeInsets.only(right: 10, bottom: 40),
                isFocused: true,
              ),
              onTap: () {
                 Navigator.of(context).pushNamed(RouterName.FIND_GROUPEMENT);
              },
            ),
            InkWell(
                child: _ItemOption(
                  title: S.of(context).lbl_subvention_ip,
                  image: R.image.ic_subvention_white,
                  number: S.of(context).lbl_number_subvention_ip(total_subventions),
                  margin: EdgeInsets.only(left: 10, bottom: 40),
                  isFocused: false,
                )



                ),
            // Navigator.of(context).pushNamed(RouterName.SCAN_BARCODE);
          ]),
          TableRow(children: [
            InkWell(
              child: _ItemOption(
                  title: S.of(context).lbl_activity_ip,
                  image: R.image.ic_activity_white,
                  number: S.of(context).lbl_number_activity_ip(total_productivesactivities),
                  margin: EdgeInsets.only(right: 10, bottom: 40)),
              onTap: () {},
            ),
            InkWell(
              child: _ItemOption(
                  title: S.of(context).lbl_training_ip,
                  image: R.image.ic_training_white,
                  number: S.of(context).lbl_number_training_ip('0'),
                  margin: EdgeInsets.only(left: 10)),
              onTap: () {},
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
            margin: EdgeInsets.only(bottom: 40),
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
                style:
                    TextStyle(color: Colors.white, fontSize: 12)),
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
