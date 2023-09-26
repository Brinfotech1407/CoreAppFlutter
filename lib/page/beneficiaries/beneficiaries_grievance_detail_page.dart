import 'package:mspmis/model/beneficiary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/generated/i18n.dart';
import 'package:mspmis/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BeneficiaryGrievanceDetailPage extends StatefulWidget {
  BeneficiaryGrievanceDetailPage({Key key, this.grievance}) : super(key: key);
  final GrievanceModel grievance;

  @override
  _BeneficiaryGrievanceDetailPageState createState() {
    return _BeneficiaryGrievanceDetailPageState();
  }
}

class _BeneficiaryGrievanceDetailPageState
    extends State<BeneficiaryGrievanceDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
          context: context,
          leading: ButtonBackWhite(context),
          title: TitleAppBarWhite(title: 'Grievance Detail')),
      body: Container(
        padding: EdgeInsets.only(left: 20, top: 20, right: 20),
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '',
                    style: TextStyle(
                        color: R.color.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      S.of(context).lbl_grievancetype(
                          widget.grievance.grievance_types_id.toString()),
                      style: TextStyle(color: R.color.grey, fontSize: 16),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      S.of(context).lbl_grievancecategory(
                          widget.grievance.grievance_categories_id.toString()),
                      style: TextStyle(color: R.color.grey, fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      SvgPicture.asset(R.image.ic_calendar_black),
                      Container(
                        //width: 1,
                        height: 20,
                        margin: EdgeInsets.only(right: 16, left: 16),
                        color: R.color.white,
                        child: Text("Request Date : ",
                            style:
                                TextStyle(color: R.color.black, fontSize: 16)),
                      ),
                      Text(
                        widget.grievance.grievance_date == null
                            ? ""
                            : widget.grievance.grievance_date.substring(0, 10),
                        style: TextStyle(color: R.color.black, fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
            ),
            _ItemExpand(
                title: 'Description',
                content: widget.grievance.description == null
                    ? ""
                    : widget.grievance.description),
            _ItemExpand(
                title: 'Decision',
                content: widget.grievance.decision == null
                    ? ""
                    : widget.grievance.decision),
            _ItemExpand(
                title: 'Raison Rejet',
                content: widget.grievance.rejet == null
                    ? ""
                    : widget.grievance.rejet),
          ],
        ),
      ),
    );
  }
}

Widget _ItemExpand({String title, String content}) => Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        color: R.color.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      content,
                      style: TextStyle(
                        color: R.color.grey,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              )),
              SvgPicture.asset(R.image.ic_expand)
            ],
          ),
        ),
      ),
    );
