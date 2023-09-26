import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mspmis/page/payment/payment_detail_page.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/generated/i18n.dart';
//import 'package:flutter_barcanner/flutter_barcode_scanner.dart';
import 'package:mspmis/model/beneficiary_model.dart';
import 'package:mspmis/helpers/DatabaseHelper.dart';
import 'package:mspmis/utils/utils.dart';

class VouchersPage extends StatefulWidget {
  @override
  _VouchersPageState createState() {
    return _VouchersPageState();
  }
}

class _VouchersPageState extends State<VouchersPage>
    with AutomaticKeepAliveClientMixin<VouchersPage> {
  //List<String> _scanBarcode;
  ScanResult _scanBarcode;

  final _flashOnController = TextEditingController(text: "Flash on");
  final _flashOffController = TextEditingController(text: "Flash off");
  final _cancelController = TextEditingController(text: "Cancel");
  var _aspectTolerance = 0.00;
  var _numberOfCameras = 0;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;
  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MainAppBar(
          context: context,
          leading: ButtonBackWhite(context),
          title: TitleAppBarWhite(title: S.of(context).title_vouchers),
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
          child: Text(
            S.of(context).lbl_hello(''),
            style: TextStyle(
                color: R.color.black,
                fontWeight: FontWeight.w600,
                fontSize: 32),
          ),



            ),
            Container(
          child: Text(
            S.of(context).lbl_voucher_management.toUpperCase(),
            style: TextStyle(
                color: R.color.gray,
                fontSize: 28,
                fontWeight: FontWeight.bold),
          ),



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
                title: S.of(context).lbl_voucher_nfc,
                image: R.image.ic_nfc_white,
                number: S.of(context).lbl_number_vouchers_transaction('0'),
                margin: EdgeInsets.only(right: 10, bottom: 40),
                isFocused: false,
              ),
              onTap: () {
                // Navigator.of(context).pushNamed(RouterName.SCAN_BARCODE);
              },
            ),
            InkWell(
                child: _ItemOption(
                  title: S.of(context).lbl_voucher_barcode,
                  image: R.image.ic_scan_white,
                  number: S.of(context).lbl_number_vouchers_transaction('0'),
                  margin: EdgeInsets.only(left: 10, bottom: 40),
                  isFocused: true,
                ),
                onTap: () async {
                  try {
                    var options = ScanOptions(
                      strings: {
                        "cancel": _cancelController.text,
                        "flash_on": _flashOnController.text,
                        "flash_off": _flashOffController.text,
                      },
                      restrictFormat: selectedFormats,
                      useCamera: _selectedCamera,
                      autoEnableFlash: _autoEnableFlash,
                      android: AndroidOptions(
                        aspectTolerance: _aspectTolerance,
                        useAutoFocus: _useAutoFocus,
                      ),
                    );

                    var result = await BarcodeScanner.scan(options: options);

                    //setState(() => _scanBarcode = result);

                    //setState(() async {
                      _scanBarcode = result;
                      print("Barcode" + result.rawContent);
                      BeneficiaryModel results = await DatabaseHelper.instance
                          .fetchBeneficairyByBarcode(
                              _scanBarcode.rawContent.split("-"));
                      results != null
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentDetailPage(
                                    beneficiary: results,
                                    type_result:
                                        'SCAN'), //_scanBarcode.rawContent.split("-")),
                              ),
                            )
                          : Navigator.of(context)
                              .pushNamed(RouterName.BENEFICIARY_MENU);
                   // });
                  } on PlatformException catch (e) {
                    ScanResult result = ScanResult(
                      type: ResultType.Error,
                      format: BarcodeFormat.unknown,
                    );

                    if (e.code == BarcodeScanner.cameraAccessDenied) {
                      setState(() {
                        result.rawContent!=
                            'The user did not grant the camera permission!';
                      });
                    } else {
                     // result.rawContent = 'Unknown error: $e';
                    }
                  }
                  var result = await BarcodeScanner.scan();
                  String results = await FlutterBarcodeScanner.scanBarcode(
                      '#000000', 'Annuler', false, ScanMode.BARCODE);
                  if (results != null) {
                    setState(() {
                      // _scanBarcode = result.split("-");
                      print("Barcode" + results);
                      List<String> scanResults=<String>[results];

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PaymentDetailPage(barcode: scanResults),
                        ),
                      );
                    });
                  }


                }),
            // Navigator.of(context).pushNamed(RouterName.SCAN_BARCODE);
          ]),
          TableRow(children: [
            InkWell(
              child: _ItemOption(
                  title: S.of(context).lbl_voucher_history,
                  image: R.image.ic_history_white,
                  number: S.of(context).lbl_number_vouchers_transaction('0'),
                  margin: EdgeInsets.only(right: 10, bottom: 40)),
              onTap: () {},
            ),
            InkWell(
              child: _ItemOption(
                  title: S.of(context).lbl_setup_management,
                  image: R.image.ic_setup_white,
                  number: S.of(context).lbl_shop_online,
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Container(
            child: Text(number,
                style:
                    TextStyle(color: Colors.white.withAlpha(50), fontSize: 14)),
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
