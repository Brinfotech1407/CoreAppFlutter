import 'package:mspmis/helpers/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/generated/i18n.dart';
import 'package:mspmis/utils/custom_gradient_prgress.dart';
import 'package:mspmis/utils/utils.dart';
import "package:intl/intl.dart";

class PaymentDashboardPage extends StatefulWidget {
  @override
  _PaymentDashboardPageState createState() => _PaymentDashboardPageState();
}

class _PaymentDashboardPageState extends State<PaymentDashboardPage> {
  double _proportion_global = 0.00;
  List<Map> _proportionList;
  bool _isCalculated = false;

  @override
  void initState() {
    super.initState();
    _calculateProportion();
  }

  Future<void> _calculateProportion() async {
    double _proportionResults = 0.00;
    List<Map> _proportionListResults = new List<Map>();

    var x = await DatabaseHelper.instance.fetchQuery(
        "SELECT SUM(amount) as total_amount FROM espmis_transactions WHERE transaction_status = 1");

    var w = await DatabaseHelper.instance
        .fetchQuery("SELECT COUNT(*) as quota FROM espmis_beneficiaries");

    List<Map> z = await DatabaseHelper.instance.fetchQuery(
        "SELECT transaction_site as site, t.site_id as site_id, SUM(amount) as total_amount FROM espmis_transactions t JOIN espmis_beneficiaries b on b.id = t.beneficiary_id WHERE transaction_status = 1 GROUP BY t.site_id order by t.site_id");

    for (int i = 0; i < z.length; i++) {
      int siteid = z[i]['site_id'];
      var y = await DatabaseHelper.instance.fetchQuery(
          "SELECT COUNT(distinct id) as quota FROM espmis_beneficiaries WHERE site_id = $siteid order by site_id");

      _proportionListResults.add({
        'site': z[i]['site'],
        'total_amount': z[i]['total_amount'],
        'percentage': (z[i]['total_amount'] / (y[0]['quota'] * 30000 * 9))
      });
    }

    print(w);
    print(x);
    if (w[0]['quota'] > 0 && x[0]['total_amount'] != null) {
      _proportionResults =
          (x[0]['total_amount'] / (w[0]['quota'] * 30000 * 9)) * 100;
    }

    setState(() {
      _isCalculated = true;
      _proportion_global = _proportionResults;
      _proportionList = _proportionListResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              S.of(context).lbl_total_payment,
              style: TextStyle(
                  color: R.color.grey,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: EdgeInsets.zero,
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: _proportion_global.toStringAsFixed(2),
                    style: TextStyle(
                        color: R.color.dark_blue,
                        fontSize: 96,
                        fontWeight: FontWeight.w600)),
                TextSpan(
                    text: '%',
                    style: TextStyle(color: R.color.dark_blue, fontSize: 48))
              ])),
            ),
            Expanded(
                child: _isCalculated == true
                    ? Padding(
                        padding: EdgeInsets.zero,
                        child: ListView.builder(
                          itemBuilder: (context, pos) =>
                              _ItemProportionDashboard(_proportionList[pos]),
                          itemCount: _proportionList.length,
                        ))
                    : Container())
          ],
        ),
      ),
    );
  }
}

Widget _ItemProportionDashboard(Map element) => Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Card(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SvgPicture.asset(R.image.ic_map_blue),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      element['site'].toString(),
                      style: TextStyle(color: R.color.grey, fontSize: 15),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                        child: RichText(
                            text: TextSpan(children: [
                      TextSpan(
                          text: NumberFormat.currency(name: 'DJF ')
                              .format(element['total_amount'])
                              .toString(), // element['total_amount'].toString(),
                          style: TextStyle(
                              color: R.color.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                      TextSpan(
                          text: '',
                          style: TextStyle(color: R.color.black, fontSize: 13))
                    ]))),
                    Column(
                      children: <Widget>[
                        Text(
                          (element['percentage'] * 100).toStringAsFixed(2) +
                              '%',
                          style: TextStyle(
                              color: R.color.dark_blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                        Container(
                          child: CustomGradientProgress(
                            isCircle: true,
                            background: R.color.dark_white,
                            gradient: LinearGradient(
                                colors: [R.color.blue, R.color.light_blue],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight),
                            value: element['percentage'],
                          ),
                          height: 4,
                          width: 100,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
