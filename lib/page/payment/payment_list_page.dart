import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:mspmis/helpers/DatabaseHelper.dart';
import 'package:badges/badges.dart' as badges;
import 'package:mspmis/utils/utils.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:mspmis/generated/i18n.dart';

class PaymentListPage extends StatefulWidget {
  @override
  _PaymentListPage createState() => _PaymentListPage();
}

class _PaymentListPage extends State<PaymentListPage> {
  bool sort;
  List<Map<String, dynamic>> results;
  List<Map<String, dynamic>> selectedList;
  // manage state of modal progress HUD widget
  bool _isInAsyncCall = false;
  onSelectedRow(bool selected, Map<String, dynamic> data) async {
    setState(() {
      if (selected) {
        selectedList.add(data);
      } else {
        selectedList.remove(data);
      }
    });
  }

  bool onCheckRow(Map<String, dynamic> data) {
    bool isIn = false;
    for (int i = 0; i < selectedList.length; i++) {
      if (selectedList[i]['benefitbeneficiary_id'] ==
          data['benefitbeneficiary_id']) isIn = true;
    }

    return isIn;
  }

  onSortColumn(int columnIndex, bool ascending) {
    if (columnIndex == 1) {
      if (ascending) {
        results.sort((a, b) => a['name'].compareTo(b['name']));
      } else {
        results.sort((a, b) => b['name'].compareTo(a['name']));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    init();
    selectedList = [];
    setState(() {
      _isInAsyncCall = true;
    });
  }

  init() async {
    sort = false;
    List<Map<String, dynamic>> _results =
        await DatabaseHelper.instance.fetchTransactionsToBePaid();

    setState(() {
      results = _results;
      _isInAsyncCall = false;
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    Widget mHeading(var value) {
      return Text(value, style: boldTextStyle());
    }

    return SafeArea(
      child: Scaffold(
        appBar: MainAppBar(
            context: context,
            leading: ButtonBackWhite(context),
            //title: TitleAppBarWhite(title: S.of(context).title_payment_details),
            title: TitleAppBarWhite(title: "Payment Details"),
            actions: []),
        body: ModalProgressHUD(
          child: ListView(
            padding: EdgeInsets.all(16),
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              Row(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: results == null
                    ? Container(
                        child: Text('No Data'),
                      )
                    : DataTable(
                        columns: <DataColumn>[
                          DataColumn(label: mHeading('Recipiendaire')),
                          DataColumn(label: mHeading('Site')),
                          DataColumn(label: mHeading('payment Status')),
                          DataColumn(label: mHeading('Transaction Date')),
                          DataColumn(label: mHeading('Synchronization Date')),
                          DataColumn(label: mHeading('Synchronization Status')),
                          DataColumn(label: mHeading('Action')),
                        ],
                        rows: results
                            .map(
                              (data) => DataRow(
                                selected: onCheckRow(data),
                                onSelectChanged: (t) {
                                  print(t);

                                  onSelectedRow(t, data);

                                  //toast(data['name']);
                                },
                                cells: [
                                  DataCell(Text(data['name'],
                                      style: secondaryTextStyle())),
                                  DataCell(Text(data['siteLabel'],
                                      style: secondaryTextStyle())),
                                  DataCell(badges.Badge(
                                    badgeColor: data['new_benefit_flag'] == ""
                                        ? Colors.red
                                        : Colors.green,
                                    shape: badges.BadgeShape.square,
                                    //borderRadius: 20,
                                    toAnimate: false,
                                    badgeContent: Text(
                                        data['new_benefit_flag'] == "1"
                                            ? " Paye "
                                            : "Non Paye",
                                        style: TextStyle(color: Colors.white)),
                                  )),
                                  DataCell(Text(
                                      data['transaction_date'] == null
                                          ? ""
                                          : data['transaction_date'],
                                      style: secondaryTextStyle())),
                                  DataCell(Text(
                                      data['synchronization_date'] == null
                                          ? ""
                                          : data['synchronization_date'],
                                      style: secondaryTextStyle())),
                                  DataCell(badges.Badge(
                                    badgeColor:
                                        data['synchronization_date'] == ""
                                            ? Colors.red
                                            : Colors.green,
                                    shape: badges.BadgeShape.square,
                                    //borderRadius: 20,
                                    toAnimate: false,
                                    badgeContent: Text(
                                        data['synchronization_date'] == ""
                                            ? " No Synchronized "
                                            : "Synchronized",
                                        style: TextStyle(color: Colors.white)),
                                  )),
                                  DataCell(data['synchronization_date'] == ""
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(Icons.edit,
                                                  color: Colors.blueAccent,
                                                  size: 30),
                                              onPressed: () {},
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.delete_forever,
                                                  color: Colors.blueAccent,
                                                  size: 30),
                                              onPressed: () {},
                                            ),
                                          ],
                                        )
                                      : Container())
                                ],
                              ),
                            )
                            .toList(),
                      ).visible(results.isNotEmpty),
              ),
            ],
          ),
          inAsyncCall: _isInAsyncCall,
          // demo of some additional parameters
          opacity: 0.5,
          progressIndicator: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
