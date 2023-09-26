import 'package:another_flushbar/flushbar.dart';
import 'package:mspmis/helpers/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/generated/i18n.dart';
import 'package:mspmis/utils/utils.dart';
import 'package:mspmis/model/beneficiary_model.dart';
//import 'package:mspmis/utils/item_payment_detail_widget.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import "package:intl/intl.dart";

class PaymentDetailPage extends StatefulWidget {
  PaymentDetailPage(
      {Key key,
      this.beneficiary,
      this.barcode,
      this.type_action,
      this.type_result})
      : super(key: key);
  BeneficiaryModel beneficiary;
  List<String> barcode;
  String type_action;
  String type_result;
  String finalDate = '';
  String finalTime = '';

  @override
  _PaymentDetailPageState createState() {
    return _PaymentDetailPageState();
  }
}

class _PaymentDetailPageState extends State<PaymentDetailPage> {
  bool isSearching = false;
  int _total_to_be_paid = 0;
  List<TransactionModel> _availableTransactionToBePaid = [];
  List<TransactionModel> _selectedTransactionToPaid = [];
  FocusNode _focusSearch = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadBeneficiary();
  }

  void _updateBeneficiaryTransaction(List<TransactionModel> t) async {
    if (t.isNotEmpty) {
      int result = await DatabaseHelper.instance.updateTransactions(t);

      setState(() {
        _loadBeneficiary();
        _selectedTransactionToPaid = [];
        _total_to_be_paid = 0;
      });

      Flushbar(
        title: "Payment",
        message: "Transaction was udpated ",
        duration: Duration(seconds: 3),
      ).show(context);
    } else {
      Flushbar(
        title: "Payment",
        message: "Update failed ",
        duration: Duration(seconds: 3),
      ).show(context);
    }
  }

  void _loadBeneficiary() async {
    BeneficiaryModel results = widget.type_result == 'SCAN'
        ? widget.beneficiary
        : await DatabaseHelper.instance
            .fetchBeneficairyByBarcode(widget.barcode);
    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    var formattedTime =
        "${dateParse.hour}-${dateParse.minute}-${dateParse.second}";

    setState(() {
      widget.type_action = "SELECT_TRANSACTION";
      if (results.transactions != null) {
        _availableTransactionToBePaid = results.transactions;
        widget.beneficiary = results;
      } else {
        _availableTransactionToBePaid = [];
      }

      widget.finalDate = formattedDate.toString();
      widget.finalTime = formattedTime.toString();
    });
  }

  _selectTransaction() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Transactions A Payer"),
          content: Stack(
            clipBehavior: Clip.none, children: <Widget>[
              Positioned(
                right: -40.0,
                top: -40.0,
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.close),
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
              StatefulBuilder(
                builder: (BuildContext context, StateSetter alertState) {
                  return Container(
                    width: 350.0,
                    height: 150.0,
                    child: ListView.builder(
                      itemCount: _availableTransactionToBePaid.length,
                      itemBuilder: (context, transactionIndex) {
                        return CheckboxListTile(
                            title: Text("TM n°" +
                                "     " +
                                S.of(context).lbl_price(
                                    NumberFormat.currency(name: 'DJF ')
                                        .format(_availableTransactionToBePaid[
                                                transactionIndex]
                                            .amount)
                                        .toString())),
                            value: _selectedTransactionToPaid.contains(
                                _availableTransactionToBePaid[
                                    transactionIndex]),
                            onChanged: (bool value) {
                              if (_selectedTransactionToPaid.contains(
                                  _availableTransactionToBePaid[
                                      transactionIndex])) {
                                _selectedTransactionToPaid.remove(
                                    _availableTransactionToBePaid[
                                        transactionIndex]);
                              } else {
                                _selectedTransactionToPaid.add(
                                    _availableTransactionToBePaid[
                                        transactionIndex]);
                              }
                              setState(() {
                                _total_to_be_paid = 0;
                                for (int i = 0;
                                    i < _selectedTransactionToPaid.length;
                                    i++) {
                                  _total_to_be_paid +=
                                      _selectedTransactionToPaid[i].amount;
                                }
                                if (_total_to_be_paid > 0) {
                                  widget.type_action = "PAID_TRANSACTION";
                                }
                              }); //ALSO UPDATE THE PARENT STATE
                              alertState(() {});
                            }
                            //secondary: const Icon(Icons.hourglass_empty),
                            );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AlertDialog mAlertItem2 = AlertDialog(
      backgroundColor: R.color.white,
      title: Text(
        "Confirmation",
        style: TextStyle(
            color: R.color.dark_black,
            fontWeight: FontWeight.w600,
            fontSize: 25),
      ),
      content: Text(
        "Voulez-vous proceder au paiement?",
        style: TextStyle(
            color: Colors.black87.withAlpha(100),
            fontWeight: FontWeight.w600,
            fontSize: 22),
      ),
      actions: [
        TextButton(
          child: Text(
            "Yes",
            style: TextStyle(
                color: R.color.dark_blue,
                fontWeight: FontWeight.w600,
                fontSize: 20),
          ),
          onPressed: () {
            _updateBeneficiaryTransaction(_selectedTransactionToPaid);
            setState(() {
              _loadBeneficiary();
            });
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            "No",
            style: TextStyle(
                color: R.color.dark_blue,
                fontWeight: FontWeight.w600,
                fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    return Scaffold(
      appBar: MainAppBar(
          context: context,
          leading: ButtonBackWhite(context),
          title: TitleAppBarWhite(title: S.of(context).title_payment_details),
          actions: []),
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Column(
          children: <Widget>[
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          CustomCircleAvatar(
                              child: widget.beneficiary.photo == null
                                  ? Image.asset(R.image.avatar)
                                  : new Image.memory(
                                      base64Decode(widget.beneficiary.photo))),
                          Positioned(
                            child: SizedBox(
                              width: 10,
                              height: 10,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  color: Color(0xFFFF2323),
                                ),
                              ),
                            ),
                            right: 0,
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.beneficiary.name,
                              style: TextStyle(
                                  color: R.color.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                S.of(context).lbl_individualid(
                                    widget.beneficiary.individualid),
                                style: TextStyle(
                                    color: R.color.grey, fontSize: 16),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                S.of(context).lbl_householdid(
                                    widget.beneficiary.householdid),
                                style: TextStyle(
                                    color: R.color.grey, fontSize: 16),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
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
                        width: 1,
                        height: 20,
                        margin: EdgeInsets.only(right: 16, left: 16),
                        color: R.color.dark_white,
                      ),
                      Text(
                        widget.finalDate,
                        style: TextStyle(color: R.color.black, fontSize: 18),
                      )
                    ],
                  ),
                ),
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
                      SvgPicture.asset(R.image.ic_clock_black),
                      Container(
                        width: 1,
                        height: 20,
                        margin: EdgeInsets.only(right: 16, left: 16),
                        color: R.color.dark_white,
                      ),
                      Text(
                        widget.finalTime,
                        style: TextStyle(color: R.color.black, fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 16),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin:
                              EdgeInsets.only(bottom: 16, left: 16, right: 16),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: RichText(
                                      text: TextSpan(children: [
                                TextSpan(
                                    text: 'Transactions',
                                    style: TextStyle(
                                        color: R.color.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                                TextSpan(
                                    text: '',
                                    style: TextStyle(
                                        color: R.color.grey, fontSize: 12))
                              ]))),
                              Container(
                                child: InkWell(
                                  child: SvgPicture.asset(R.image.ic_edit_goal),
                                  onTap: () {
                                    _availableTransactionToBePaid.isNotEmpty
                                        ? _selectTransaction()
                                        : Container();
                                  },
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                      blurRadius: 15,
                                      spreadRadius: -6,
                                      color: R.color.blue,
                                      offset: Offset(0, 1))
                                ]),
                              )
                            ],
                          ),
                        ),
                        /*
                          child: Text(
                            'Transactions',
                            style: TextStyle(
                                color: R.color.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          child: InkWell(
                            child: SvgPicture.asset(R.image.ic_edit_goal),
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(RouterName.SET_GOAL);
                            },
                          ),
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                blurRadius: 15,
                                spreadRadius: -6,
                                color: R.color.blue,
                                offset: Offset(0, 1))
                          ]),
                        ),*/
                        Divider(
                          height: 1,
                          color: R.color.dark_white,
                        ),
                        Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _selectedTransactionToPaid.length,
                              itemBuilder: (context, index) {
                                return Column(children: <Widget>[
                                  // Widget to display the list of project
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 5, right: 16, left: 16, bottom: 2),
                                    child: Row(children: <Widget>[
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            _selectedTransactionToPaid[index]
                                                    .transaction_type +
                                                " " +
                                                DateFormat.yQQQQ().format(
                                                    DateTime.parse(
                                                        _selectedTransactionToPaid[
                                                                index]
                                                            .start_date)),
                                            style: TextStyle(
                                                color: R.color.grey,
                                                fontSize: 16),
                                          ),
                                        ],
                                      )),
                                      Text(
                                        S.of(context).lbl_price(
                                            NumberFormat.currency(name: 'DJF ')
                                                .format(
                                                    _selectedTransactionToPaid[
                                                            index]
                                                        .amount)
                                                .toString()),
                                        style: TextStyle(
                                            color: _selectedTransactionToPaid[
                                                            index]
                                                        .transaction_status ==
                                                    2
                                                ? R.color.dark_black
                                                : R.color.grey,
                                            fontSize: 18),
                                      ),
                                    ]),
                                  )
                                ]);
                              }),
                        ),
                        Divider(
                          height: 1,
                          color: R.color.dark_white,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, right: 16, left: 16),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'Total A Payer',
                                  style: TextStyle(
                                      color: R.color.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Text(
                                S.of(context).lbl_price(
                                    NumberFormat.currency(name: 'DJF ')
                                        .format(_total_to_be_paid)
                                        .toString()),
                                style: TextStyle(
                                    color: R.color.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Container(
              margin: EdgeInsets.only(top: 32),
              child: _selectedTransactionToPaid.isNotEmpty
                  ? button(
                      width: 250,
                      text: S.of(context).btn_save_payment.toUpperCase(),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return mAlertItem2;
                          },
                        );
                      })
                  : Container(),
            ), /*
            Positioned(
              top: 25,
              right: 25,
              child: InkWell(
                child: Container(
                  child: SvgPicture.asset(R.image.ic_edit),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Color(0xFF416CE3).withAlpha(60),
                        blurRadius: 25,
                        offset: Offset(0, 2)),
                    BoxShadow(
                        color: R.color.dark_black.withAlpha(50),
                        blurRadius: 25,
                        spreadRadius: -10,
                        offset: Offset(0, 2))
                  ]),
                ),
              ),
            )*/
          ],
        ),
      ),
    );
  }
}
