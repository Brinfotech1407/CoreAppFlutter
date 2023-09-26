import 'package:mspmis/model/beneficiary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/generated/i18n.dart';
import 'package:mspmis/utils/utils.dart';
import 'package:badges/badges.dart' as badges;
import 'package:mspmis/page/payment/payment_detail_page.dart';
import 'package:mspmis/helpers/DatabaseHelper.dart';

class BenefciariesPaymentPage extends StatefulWidget {
  BenefciariesPaymentPage({Key key, this.beneficiary}) : super(key: key);
  final BeneficiaryModel beneficiary;

  @override
  _BenefciariesPaymentState createState() {
    return _BenefciariesPaymentState();
  }
}

class _BenefciariesPaymentState extends State<BenefciariesPaymentPage> {
  bool isSearching = false;
  FocusNode _focusSearch = FocusNode();

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    List<TransactionModel> result =
        await DatabaseHelper.instance.fetchTransactions(widget.beneficiary.id);

    setState(() {
      widget.beneficiary.transactions = result;
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
                  title: S.of(context).title_beneficairies_payment),
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
        child:

            ListView.builder(
          itemBuilder: (context, pos) => _ItemTransaction(context,
              widget.beneficiary.transactions[pos], widget.beneficiary, pos),
          itemCount: widget.beneficiary.transactions == null
              ? 0
              : widget.beneficiary.transactions.length,
        ),
      ),
    );
  }
}

Widget _ItemTransaction(BuildContext context, TransactionModel t,
        BeneficiaryModel b, int pos) =>
    Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color(0xFFF3F6FE),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8))),
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset(R.image.ic_tabbar_addpayment_blue),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'TM n°' + (pos + 1).toString(),
                        style: TextStyle(
                            color: R.color.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(
                            S.of(context).lbl_payment_site,
                            style: TextStyle(color: R.color.grey, fontSize: 16),
                          )),
                          Expanded(
                              child: Text(
                            S.of(context).lbl_period_benefit,
                            style: TextStyle(color: R.color.grey, fontSize: 16),
                          )),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Text(
                              t.transaction_site,
                              style:
                                  TextStyle(color: R.color.black, fontSize: 18),
                            )),
                            Expanded(
                                child: Text(
                              'From ' + t.start_date + ' To ' + t.end_date,
                              style:
                                  TextStyle(color: R.color.black, fontSize: 18),
                            ))
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              S.of(context).lbl_enrollee_id,
                              style:
                                  TextStyle(color: R.color.grey, fontSize: 16),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            S.of(context).lbl_date_effective,
                            style: TextStyle(color: R.color.grey, fontSize: 16),
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              b.householdid + "/" + b.individualid,
                              style:
                                  TextStyle(color: R.color.black, fontSize: 18),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            '',
                            style:
                                TextStyle(color: R.color.black, fontSize: 18),
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              S.of(context).lbl_date_transaction,
                              style:
                                  TextStyle(color: R.color.grey, fontSize: 16),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            S.of(context).lbl_transaction_amount,
                            style: TextStyle(color: R.color.grey, fontSize: 16),
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              t.transaction_date == null
                                  ? ''
                                  : t.transaction_date,
                              style:
                                  TextStyle(color: R.color.black, fontSize: 18),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            t.amount.toString(),
                            style:
                                TextStyle(color: R.color.black, fontSize: 18),
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: t.transaction_status == "1"
                                ? Container()
                                : t.transaction_new_status == ""
                                    ? t.transaction_status == "2"
                                        ? button(
                                            width: 20,
                                            text: S
                                                .of(context)
                                                .btn_to_be_paid
                                                .toUpperCase(),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PaymentDetailPage(
                                                    barcode: [
                                                      b.id.toString(),
                                                      b.householdid,
                                                      b.individualid
                                                    ],
                                                    type_result: 'FIND',
                                                  ),
                                                ),
                                              );
                                            })
                                        : Container()
                                    : Container(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 10,
            right: 25,
            child: InkWell(
              child: Container(
                  child: badges.Badge(
                badgeColor: t.transaction_status == "1"
                    ? Colors.green
                    : t.transaction_new_status == ""
                        ? t.transaction_status == "2"
                            ? Colors.red
                            : Colors.orange
                        : Colors.green,
                shape: badges.BadgeShape.square,
                // borderRadius: 20,
                toAnimate: false,
                badgeContent: Text(
                    t.transaction_status == "1"
                        ? " Payee "
                        : t.transaction_new_status == ""
                            ? t.transaction_status == "2"
                                ? "Non Payee"
                                : " Annulee"
                            : "Payee",
                    style: TextStyle(color: Colors.white)),
              )),
            ),
          )
        ],
      ),
    );
