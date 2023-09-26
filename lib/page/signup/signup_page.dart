import 'package:flutter/material.dart';
import 'package:mspmis/generated/i18n.dart';
import 'package:mspmis/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:mspmis/contanst/contanst.dart';

import 'signup_page_model.dart';

class SignUpPage extends StatelessWidget {
  static Widget ProviderPage() {
    return ChangeNotifierProvider<SignUpPageModel>(
      create: (_) => SignUpPageModel(),
      child: SignUpPage(),
    );
  }

  static SignUpPageModel of(BuildContext context) =>
      Provider.of<SignUpPageModel>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.only(left: 36, right: 36, bottom: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: Text(
                        S.of(context).title_sign_up.toUpperCase(),
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.w700),
                      ),
                      margin: EdgeInsets.only(bottom: 30),
                    ),
                    Container(
                      child: TextFormField(
                        focusNode: SignUpPage.of(context).focusUsername,
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        style: inputTextStyle(),
                        decoration: inputImageDecoration(
                          hintText: S.of(context).hint_input_username,
                          image: R.image.ic_user,
                        ),
                        onFieldSubmitted: (value) {
                          SignUpPage.of(context).nextFocus(
                              context,
                              SignUpPage.of(context).focusUsername,
                              SignUpPage.of(context).focusPassword);
                        },
                      ),
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    Container(
                      child: TextFormField(
                        focusNode: SignUpPage.of(context).focusPassword,
                        style: inputTextStyle(),
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        decoration: inputImageDecoration(
                          hintText: S.of(context).hint_input_password,
                          image: R.image.ic_password,
                        ),
                        onFieldSubmitted: (value) {
                          SignUpPage.of(context).nextFocus(
                              context,
                              SignUpPage.of(context).focusPassword,
                              SignUpPage.of(context).focusPasswordConfirm);
                        },
                      ),
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    Container(
                      child: TextFormField(
                        focusNode: SignUpPage.of(context).focusPasswordConfirm,
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        style: inputTextStyle(),
                        decoration: inputImageDecoration(
                          hintText: S.of(context).hint_input_password,
                          image: R.image.ic_password,
                        ),
                        onFieldSubmitted: (value) {
                          SignUpPage.of(context).nextFocus(
                              context,
                              SignUpPage.of(context).focusPasswordConfirm,
                              SignUpPage.of(context).focusEmail);
                        },
                      ),
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    Container(
                      child: TextFormField(
                        focusNode: SignUpPage.of(context).focusEmail,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        style: inputTextStyle(),
                        decoration: inputImageDecoration(
                          hintText: S.of(context).hint_input_email,
                          image: R.image.ic_email,
                        ),
                        onFieldSubmitted: (value) {
                          SignUpPage.of(context).closeFocus(
                              context, SignUpPage.of(context).focusEmail);
                        },
                      ),
                      margin: EdgeInsets.only(bottom: 0),
                    ),
                    Container(
                      child: button(
                          text: S.of(context).btn_sign_up.toUpperCase(),
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(RouterName.CREATE_ACCOUNT);
                          }),
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                    ),
                    button(
                        text: S.of(context).btn_sign_up_facebook.toUpperCase(),
                        onPressed: () {}),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    S.of(context).lbl_have_account,
                    style: TextStyle(fontSize: 16, color: R.color.gray),
                  ),
                  InkWell(
                    child: Text(
                      S.of(context).btn_sign_in.toUpperCase(),
                      style: TextStyle(fontSize: 16, color: R.color.blue),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
