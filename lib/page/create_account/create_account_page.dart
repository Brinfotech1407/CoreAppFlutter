
import 'package:flutter/material.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/generated/i18n.dart';
import 'package:mspmis/page/main/main_page.dart';
import 'package:mspmis/utils/utils.dart';
import 'package:provider/provider.dart';

import 'create_account_page_model.dart';

class CreateAccountPage extends StatelessWidget {
  static Widget ProviderPage() {
    return ChangeNotifierProvider<CreateAccountPageModel>(
      create: (context) => CreateAccountPageModel(),
      child: CreateAccountPage(),
    );
  }

  static CreateAccountPageModel of(BuildContext context) =>
      Provider.of<CreateAccountPageModel>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: ButtonBackGrey(context),
        centerTitle: true,
        title: TitleAppBarBlack(title: S.of(context).title_create_account),
        actions: <Widget>[ButtonSkip(context: context, onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (contextTrans) => MainPage()),
            ModalRoute.withName(RouterName.MAIN),
          );
        })],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: Column(
          children: <Widget>[
            InkWell(
              child: InputWidget(
                hint: S.of(context).hint_input_fullname,
                text: CreateAccountPage.of(context).fullname,
                bottom: 20,
                top: 50,
              ),
              onTap: () {
                //final data = CreateAccountPage.of(context).data;
/*
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (contextTrans) =>
                       //CreateAccountFullnamePage.ProviderPage()));
                    DoctorsPage.ProviderPage()));*/
              },


            ),
            InkWell(
              child: InputWidget(
                  hint: S.of(context).hint_input_birthday,
                  text: CreateAccountPage.of(context).birthday,
                  bottom: 20),
              onTap: () {
                //final data = CreateAccountPage.of(context).data;
                Navigator.of(context).pushNamed(RouterName.CREATE_ACCOUNT_BIRTHDAY);
              },
            ),
            InkWell(
              child: InputWidget(
                  hint: S.of(context).hint_input_gender,
                  text: CreateAccountPage.of(context).gender,
                  bottom: 20),
              onTap: () {
                //final data = CreateAccountPage.of(context).data;
                Navigator.of(context).pushNamed(RouterName.CREATE_ACCOUNT_GENDER);
              },
            ),
            InkWell(
              child: InputWidget(
                  hint: S.of(context).hint_input_weight,
                  text: CreateAccountPage.of(context).weight,
                  bottom: 20),
              onTap: () {
                //final data = CreateAccountPage.of(context).data;
                Navigator.of(context).pushNamed(RouterName.CREATE_ACCOUNT_WEIGHT);
              },
            ),
            InkWell(
              child: InputWidget(
                  hint: S.of(context).hint_input_height,
                  text: CreateAccountPage.of(context).height,
                  bottom: 50),
              onTap: () {
                //final data = CreateAccountPage.of(context).data;
                Navigator.of(context).pushNamed(RouterName.CREATE_ACCOUNT_HEIGHT);
              },
            ),
            Container(
              child: button(
                  width: 250,
                  text: S.of(context).btn_submit.toUpperCase(),
                  onPressed: () {}),
            )
          ],
        ),
      ),
    );
  }
}
