import 'package:mspmis/model/beneficiary_model.dart';
import 'package:mspmis/page/beneficiaries/beneficiaries_grievance_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/generated/i18n.dart';
import 'package:mspmis/utils/utils.dart';

import 'package:mspmis/helpers/DatabaseHelper.dart';

class BenefciariesGrievancePage extends StatefulWidget {
  BenefciariesGrievancePage({Key key, this.beneficiary}) : super(key: key);
  final BeneficiaryModel beneficiary;

  @override
  _BenefciariesGrievanceState createState() {
    return _BenefciariesGrievanceState();
  }
}

class _BenefciariesGrievanceState extends State<BenefciariesGrievancePage> {
  bool isSearching = false;
  FocusNode _focusSearch = FocusNode();

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    List<GrievanceModel> result =
        await DatabaseHelper.instance.fetchGrievances(widget.beneficiary.id);

    setState(() {
      widget.beneficiary.grievances = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
          context: context,
          leading: ButtonBackWhite(context),
          title: isSearching
              ? Container(
                  padding: EdgeInsets.only(left: 10),
                  width: 300,
                  height: 30,
                  child: TextFormField(
                    focusNode: _focusSearch,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle:
                          TextStyle(color: Color(0xFF969696), fontSize: 14),
                      labelStyle: TextStyle(color: R.color.black, fontSize: 14),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Color(0xFF969696),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(200)),
                )
              : TitleAppBarWhite(
                  title: S.of(context).title_beneficairies_grievance),
          actions: isSearching
              ? []
              : [
                  IconButton(
                      icon: SvgPicture.asset(R.image.ic_search),
                      onPressed: () {
                        setState(() {
                          isSearching = true;
                        });
                      })
                ]),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: ListView.builder(
          itemBuilder: (context, pos) => _ItemGrievances(
              context: context,
              grievance: widget.beneficiary.grievances[pos],
              index: pos),
          itemCount: widget.beneficiary.grievances == null
              ? 0
              : widget.beneficiary.grievances.length,
        ),
      ),
    );
  }
}

Widget _ItemGrievances(
        {BuildContext context, GrievanceModel grievance, int index}) =>
    Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 20),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  BeneficiaryGrievanceDetailPage(grievance: grievance),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 3,
          child: Container(
            padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
            child: Row(
              children: <Widget>[
                SvgPicture.asset(R.image.ic_tabbar_addgrievance_blue),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  width: 1,
                  height: 30,
                  color: R.color.dark_white,
                ),
                Expanded(
                    child: Text(
                  'Grievance/Complaint n° ' + (index + 1).toString(),
                  style: TextStyle(color: R.color.black, fontSize: 17),
                )),
                Container(
                  child: SvgPicture.asset(R.image.ic_arrow_right),
                )
              ],
            ),
          ),
        ),
      ),
    );
