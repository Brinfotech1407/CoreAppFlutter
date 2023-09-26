import 'package:mspmis/page/loading/LoadingPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/generated/i18n.dart';
import 'package:mspmis/utils/utils.dart';
import 'package:provider/provider.dart';

import 'package:mspmis/page/find_program/find_program_page_model.dart';

class FindProgramPage extends StatelessWidget {
  FindProgramPage();

  GlobalKey _keyList = GlobalKey();

  // ignore: avoid_init_to_null
  static Widget ProviderPage() {
    return ChangeNotifierProvider<FindProgramPageModel>(
      create: (_) => FindProgramPageModel(),
     child: FindProgramPage(),

    );
  }

  static FindProgramPageModel of(BuildContext context) =>
      Provider.of<FindProgramPageModel>(context,listen: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: ButtonBackGrey(context),
          centerTitle: true,
          title: TitleAppBarBlack(title: S.of(context).title_loading),
          actions: <Widget>[
            ButtonSkip(
                context: context,
                onPressed: () {


                })
          ],
        ),
        body: Container(
            padding: EdgeInsets.only(top: 35),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 20, left: 30, right: 30),
                    child: Text(
                      S.of(context).lbl_select_program.toUpperCase(),
                      style: TextStyle(
                          color: R.color.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    key: _keyList,
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: R.color.light_blue,
                                boxShadow: [
                                  BoxShadow(
                                    color: R.color.dark_black.withAlpha(75),
                                    blurRadius: 20.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(
                                      1.0,
                                      1.0,
                                    ),
                                  )
                                ],
                              )),
                        ),
                        Container(
                          child: CupertinoPicker(
                            useMagnifier: false,
                            magnification: 0.7,
                            backgroundColor: Colors.transparent,
                            diameterRatio: 20.0,
                            children: <Widget>[
                              _ItemPicker('Programme PNSF',
                                  selected: FindProgramPage.of(context)
                                      .programSelected ==
                                      1),
                              _ItemPicker('Programme COVID',
                                  selected: FindProgramPage.of(context)
                                      .programSelected ==
                                      9),
                              _ItemPicker('Programme ASERI/VD',
                                  selected: FindProgramPage.of(context)
                                      .programSelected ==
                                      2),
                              _ItemPicker('Programme PASS',
                                  selected: FindProgramPage.of(context)
                                      .programSelected ==
                                      8),
                            ],
                            itemExtent: 70,
                            onSelectedItemChanged: (int value) {
                              FindProgramPage.of(context)
                                  .updateProgram(value);
                            },
                          ),
                          margin: EdgeInsets.only(left: 30, right: 30),
                        ),
                      ],
                    ),
                  ),

                ])));
  }
}

Widget _ItemPicker(String mss,
    {TextAlign textAlign = TextAlign.left, bool selected = false}) =>
    Container(
      alignment: Alignment.centerLeft,
      child: Text(
        mss,
        textAlign: textAlign,
        style: TextStyle(
            color: selected ? Colors.white : R.color.black, fontSize: 32),
      ),
    );
