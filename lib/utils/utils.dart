import 'package:mspmis/page/beneficiaries/beneficiaries_home_page.dart';
import 'package:mspmis/page/grievances/grievance_list_2_page.dart';
import 'package:mspmis/page/loading/LoadingPage.dart';
import 'package:mspmis/page/main/main_page.dart';
import 'package:mspmis/page/payment/payment_history_2_page.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/generated/i18n.dart';
import 'package:mspmis/page/dashboard/payment_dashboard.dart';
import 'package:mspmis/page/beneficiaries/beneficiaries_list_2_page.dart';

import 'package:mspmis/page/home/home_page.dart';

Widget _ItemMenu({String menu, bool selected = false, Function onPressed}) =>
    InkWell(
      child: Container(
        height: 60,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Visibility(
                visible: selected,
                child: Container(
                  height: 40,
                  width: 6,
                  decoration: BoxDecoration(
                      color: R.color.light_blue,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(4),
                          bottomRight: Radius.circular(4)),
                      border: Border.all(color: Color(0xFF979797)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 15,
                            spreadRadius: 0,
                            color: R.color.blue,
                            offset: Offset(-2, 3))
                      ]),
                )),
            Container(
              margin: EdgeInsets.only(left: 35),
              child: Text(
                menu,
                style: TextStyle(
                    color: selected ? Color(0xFF7696F5) : R.color.gray,
                    fontSize: 16),
              ),
            )
          ],
        ),
      ),
      onTap: selected ? null : onPressed,
    );

Widget leftMenu(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _ItemMenu(
          menu: S.of(context).menu_home,
          /*
                        selected: currentPage == 2, // Menu Left Home Link
                        onPressed: () {
                          pageController.animateToPage(2,
                              duration: Duration(milliseconds: 400),
                              curve: Curves.linear);
                          setState(() {
                            currentPage = 2;
                            isSearching = false;
                          });
                          
                          //_innerDrawerKey.currentState.close();
                        }
                        */
        ),
        _ItemMenu(
          menu: S.of(context).menu_dashboard,
          /*
                        selected:
                            currentPage == 0, // Menu Left Tableau de bord Link
                        onPressed: () {
                          pageController.animateToPage(0,
                              duration: Duration(milliseconds: 400),
                              curve: Curves.linear);
                          setState(() {
                            currentPage = 0;
                            isSearching = false;
                          });
                          
                          _innerDrawerKey.currentState.close();
                        }
                        */
        ),
        _ItemMenu(
          menu: S.of(context).menu_payments,
          /*
                        selected: currentPage == 1, //Menu Left Payment Link
                        onPressed: () {
                          pageController.animateToPage(1,
                              duration: Duration(milliseconds: 400),
                              curve: Curves.linear);
                          setState(() {
                            currentPage = 1;
                            isSearching = false;
                          });
                          
                          _innerDrawerKey.currentState.close();
                        }
                        */
        ),
        _ItemMenu(
          menu: S.of(context).menu_vouchers,
          /*
                        selected: currentPage == 4, // Menu Left Voucher Link
                        onPressed: () {
                          pageController.animateToPage(4,
                              duration: Duration(milliseconds: 400),
                              curve: Curves.linear);
                          setState(() {
                            currentPage = 4;
                            isSearching = false;
                          });
                          
                          _innerDrawerKey.currentState.close();
                        }
                        */
        ),
        _ItemMenu(menu: S.of(context).menu_beneficiaires
            /*
                        selected: currentPage == 3, // Menu Left Beneficiary Link
                        onPressed: () {
                          
                          Navigator.of(context)
                              .pushNamed(RouterName.BENEFICIARY_MENU);
                              
                        }
                        */
            ),
        _ItemMenu(menu: S.of(context).menu_programmes, onPressed: () {}),
        _ItemMenu(
            menu: S.of(context).menu_log_out,
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouterName.SIGN_IN, (Route<dynamic> route) => false);
            }),
      ],
    ),
  );
}

Widget bodyPageView(BuildContext context, PageController pageController) =>
    PageView(
      //physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        //VouchersPage(),
        PaymentDashboardPage(),
        BeneficiaryPaginableDataTablePage(),
        HomePage(),
        PaymentHistoryPaginableDataTablePage(),
        GrievanceHistoryPaginableDataTablePage(),
      ],
      controller: pageController,
      scrollDirection: Axis.horizontal,
    );

Widget getTitle(BuildContext context, int currentPage) {
  switch (currentPage) {
    case 1:
      return TitleAppBarWhite(title: S.of(context).title_beneficiaries);
    case 2:
      return TitleAppBarWhite(title: S.of(context).title_app);
    case 3:
      return TitleAppBarWhite(title: S.of(context).title_history_transaction);
    case 4:
      return TitleAppBarWhite(title: S.of(context).title_history_grievance);
    case 0:
      return TitleAppBarWhite(title: S.of(context).title_payment_dashboard);
  }
}

Widget getTitleBar(BuildContext context, int currentPage, bool isSearching,
    FocusNode focusSearch) {
  if (isSearching) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      width: double.infinity,
      height: 30,
      child: TextFormField(
        focusNode: focusSearch,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: TextStyle(color: Color(0xFF969696), fontSize: 14),
          labelStyle: TextStyle(color: R.color.black, fontSize: 14),
          suffixIcon: Icon(
            Icons.search,
            color: Color(0xFF969696),
          ),
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(200)),
    );
  } else {
    return getTitle(context, currentPage);
  }
}

List<Widget> getActions(BuildContext context, int currentPage, bool isSearching,
    FocusNode focusSearch) {
  if (isSearching) {
    return [];
  }

  switch (currentPage) {
    case 2:
      return [
        IconButton(
          icon: SvgPicture.asset(R.image.ic_mail),
          onPressed: () {},
        ),
        IconButton(
          icon: SvgPicture.asset(R.image.ic_notification),
          onPressed: () {},
        )
      ];

    case 3:
      return [
        IconButton(
          icon: SvgPicture.asset(R.image.ic_search),
          onPressed: () {
            Navigator.of(context).pushNamed(RouterName.FIND_BENEFICIARY);
          },
        ),
      ];
    default:
      return [];
  }
}

class SimpleDialogExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      title:
          Text('Message', style: TextStyle(color: R.color.black, fontSize: 18)),
      children: [
        Text("No Data", style: TextStyle(color: R.color.black, fontSize: 16)),
      ],
    );
  }
}

Widget mHeading(var value) {
  return Text(value,
      style: TextStyle(
          fontSize: 18, color: R.color.black, fontWeight: FontWeight.w600));
}

class CustomTheme extends StatelessWidget {
  Widget child;

  CustomTheme({this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
        accentColor: Color(0xFF0A79DF),
        backgroundColor: Color(0xFF131d25),
      ),
      child: child,
    );
  }
}

InputDecoration inputImageDecoration({image: String, hintText: String}) =>
    InputDecoration(
        contentPadding: EdgeInsets.all(0),
        prefixIcon: SvgPicture.asset(
          image,
          fit: BoxFit.none,
        ),
        focusedBorder: _borderTextField(),
        border: _borderTextField(),
        enabledBorder: _borderTextField(),
        hintText: hintText,
        hintStyle: hintStyle());

InputBorder _borderTextField() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(200),
      borderSide: BorderSide(
          width: 0, style: BorderStyle.solid, color: R.color.dark_white),
    );

TextStyle inputTextStyle() =>
    TextStyle(fontSize: 16, color: R.color.dark_black);

TextStyle hintStyle() => TextStyle(fontSize: 16, color: R.color.gray);

GradientButton button(
        {text: String,
        Function onPressed,
        double height = 16,
        double width = 200}) =>
    GradientButton(
      increaseHeightBy: height,
      increaseWidthBy: width,
      child: Text(
        text,
      ),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      callback: onPressed,
      gradient: BlueGradient(),
      shadowColor: Colors.black,
    );

InputDecoration inputDecoration({hintText: String}) => InputDecoration(
    contentPadding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
    focusedBorder: _borderTextField(),
    border: _borderTextField(),
    enabledBorder: _borderTextField(),
    hintText: hintText,
    hintStyle: TextStyle(fontSize: 16, color: R.color.gray));

Widget ButtonBackGrey(BuildContext context) => IconButton(
    icon: SvgPicture.asset(R.image.ic_back_grey),
    onPressed: () {
      Navigator.of(context).pop();
    });

Widget ButtonBackWhite(BuildContext context) => IconButton(
    icon: SvgPicture.asset(R.image.ic_back_white),
    onPressed: () {
      Navigator.of(context).pop();
    });

Widget TitleAppBarBlack({String title}) => Text(
      title,
      style: TextStyle(
          fontSize: 18, color: R.color.black, fontWeight: FontWeight.w600),
    );

Widget TitleAppBarWhite({String title}) => Text(
      title,
      style: TextStyle(
          fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
    );

Widget ButtonSkip({BuildContext context, Function onPressed}) => Center(
      child: IconButton(
          icon: Text(
            S.of(context).btn_navigation_skip,
            style: TextStyle(fontSize: 16, color: R.color.blue),
          ),
          onPressed: onPressed),
    );

Widget InputWidget(
        {String hint,
        String text = '',
        double bottom = 0,
        double top = 0,
        Function onTap}) =>
    Padding(
      padding: EdgeInsets.only(bottom: bottom, top: top),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          child: Text(
            text.isEmpty ? hint : text,
            style: text.isEmpty ? hintStyle() : inputTextStyle(),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            border: Border.all(
              width: 1,
              color: R.color.dark_white,
            ),
          ),
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        ),
      ),
    );

Widget MainAppBar(
        {BuildContext context,
        Widget leading,
        Widget title,
        List<Widget> actions,
        Widget bottom}) =>
    PreferredSize(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Stack(
            children: <Widget>[
              Positioned(
                child: leading == null ? Container() : leading,
                left: 0,
              ),
              Center(
                child: title == null
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.only(left: 50, right: 20),
                        child: title,
                      ),
              ),
              Positioned(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: actions == null ? [] : actions,
                ),
                right: 0,
              )
            ],
          ),
          decoration: BoxDecoration(gradient: BlueGradient()),
        ),
        preferredSize: Size(MediaQuery.of(context).size.width, 50.0));

Widget CustomCircleAvatar(
        {double size = 50, Widget child, BoxDecoration decoration}) =>
    Container(
      width: size,
      height: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50 / 2),
        child: child,
      ),
      decoration: decoration,
    );

Gradient BlueGradient() => LinearGradient(
    colors: [R.color.blue, R.color.light_blue],
    begin: Alignment.bottomLeft,
    end: Alignment.centerRight);

BoxDecoration ShadowDecorationWhite() => BoxDecoration(
      color: R.color.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
            color: Color(0xFF000000).withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 1))
      ],
    );
