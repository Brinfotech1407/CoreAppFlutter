import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/generated/i18n.dart';
import 'package:mspmis/model/beneficiary_model.dart';
import 'package:mspmis/utils/utils.dart';
import 'dart:convert';

Widget ItemPaymentDetailWidget(
        BuildContext context, TransactionModel transaction) =>
    Card(
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
              margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
              child: Text(
                'Transactions',
                style: TextStyle(
                    color: R.color.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Divider(
              height: 1,
              color: R.color.dark_white,
            ),
            Container(
              margin: EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Cash Transfer',
                        style: TextStyle(color: R.color.grey, fontSize: 16),
                      ),
                      Text(
                        'TM n°' + transaction.sequence.toString(),
                        style: TextStyle(color: R.color.blue, fontSize: 14),
                      )
                    ],
                  )),
                  Text(
                    S.of(context).lbl_price(transaction.amount.toString()),
                    style: TextStyle(color: R.color.black, fontSize: 18),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
