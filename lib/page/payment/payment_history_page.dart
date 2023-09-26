import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:mspmis/helpers/DatabaseHelper.dart';
import 'package:badges/badges.dart' as badges;
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentHistoryPage extends StatefulWidget {
  @override
  _PaymentHistoryPage createState() => _PaymentHistoryPage();
}

class _PaymentHistoryPage extends State<PaymentHistoryPage> {
  bool sort;
  List<Map<String, dynamic>> results;
  List<Map<String, dynamic>> selectedList;

  onSelectedRow(bool selected, Map<String, dynamic> data) async {
    setState(() {
      if (selected) {
        selectedList.add(data);
      } else {
        selectedList.remove(data);
      }
    });
  }

  onDeleteSelected() async {
    setState(() {
      if (selectedList.isNotEmpty) {
        selectedList = [];
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
  }

  init() async {
    sort = false;
    List<Map<String, dynamic>> _results =
        await DatabaseHelper.instance.fetchTransactionsToBeSync();

    setState(() {
      results = _results;
    });
  }

  void sendData() async {
    var mapData = new Map<String, dynamic>();
    mapData['api_key'] = '434792038709226';
    mapData['data'] = selectedList;
    String url = "http://197.241.42.179/api/payment/confirmation";
    print(selectedList);
    final http.Response response =
        await http.post(Uri.parse(url),
            headers: {
              "Content-Type": "application/json",
              'Accept': 'application/json',
              'X-Force-Content-Type': 'application/json'
            },
            body: json.encode(mapData));
    print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
     Flushbar(
        title: json.decode(response.body)['msg'],
        message: json.decode(response.body)['details'],
        duration: Duration(seconds: 5),
      ).show(context);

      for (int i = 0; i < selectedList.length; i++) {
        int update = await DatabaseHelper.instance
            .updateTransactionById(selectedList[i]['benefitbeneficiary_id']);
      }

      List<Map<String, dynamic>> _results =
          await DatabaseHelper.instance.fetchTransactionsToBeSync();

      setState(() {
        results = _results;
      });
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      Flushbar(
        title: "Synchronizarion Results",
        message: "Failed ",
       duration: Duration(seconds: 5),
      ).show(context);
    }
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
        body: ListView(
          padding: EdgeInsets.all(16),
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: [
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: OutlinedButton(
                    child: selectedList == null
                        ? Text('SELECTED : 0')
                        : Text('SELECTED : ${selectedList.length}'),
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: OutlinedButton(
                    child: Text('UNSELECTED : ${selectedList.length}'),
                    onPressed: selectedList.isEmpty
                        ? null
                        : () {
                            onDeleteSelected();
                          },
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: results == null
                  ? Container(
                      child: Text('No Data to be synchronized'),
                    )
                  : DataTable(
                      columns: <DataColumn>[
                        DataColumn(label: mHeading('Recipiendaire')),
                        DataColumn(label: mHeading('Site')),
                        DataColumn(label: mHeading('Payment Status')),
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
                                DataCell(Text(data['transaction_date'],
                                    style: secondaryTextStyle())),
                                DataCell(Text(
                                    data['synchronization_date'] == null
                                        ? ""
                                        : data['synchronization_date'],
                                    style: secondaryTextStyle())),
                                DataCell(badges.Badge(
                                  badgeColor: data['synchronization_date'] == ""
                                      ? Colors.red
                                      : Colors.green,
                                  shape: badges.BadgeShape.square,
                                 // borderRadius: 20,
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
                                            icon: Icon(Icons.sync,
                                                color: Colors.blueAccent,
                                                size: 30),
                                            onPressed: () {
                                              sendData();
                                            },
                                          ),
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
      ),
    );
  }
}
