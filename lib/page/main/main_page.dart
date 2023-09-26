import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:mspmis/generated/i18n.dart';
import 'package:mspmis/helpers/databaseHelper.dart';
import 'package:mspmis/contanst/contanst.dart';

import 'package:mspmis/utils/utils.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  int currentPage = 0;
  bool isSearching = false;
  FocusNode focusSearch = FocusNode();
  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      key: _innerDrawerKey,
      onTapClose: true,
      swipe: true,
      scaffold: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MainAppBar(
          context: context,
          title: getTitleBar(context, currentPage, isSearching, focusSearch),
          actions: getActions(context, currentPage, isSearching, focusSearch),
          leading: IconButton(
              icon: SvgPicture.asset(R.image.ic_menu_white),
              onPressed: () {
                _innerDrawerKey.currentState.open();
              }),
        ),
        body: bodyPageView(context, pageController),
        bottomNavigationBar: Container(
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(R.image.ic_tabbar_dashboard_grey),
                  activeIcon:
                      SvgPicture.asset(R.image.ic_tabbar_dashboard_blue),
                  label: ""),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(R.image.ic_tabbar_beneficiaries_grey),
                  activeIcon:
                      SvgPicture.asset(R.image.ic_tabbar_beneficiaries_blue),
                  label: ""),
              BottomNavigationBarItem(icon: Container(), label: ""),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(R.image.ic_tabbar_addpayment_grey),
                  activeIcon:
                      SvgPicture.asset(R.image.ic_tabbar_addpayment_blue),
                  label: ""),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(R.image.ic_tabbar_addgrievance_grey),
                  activeIcon:
                      SvgPicture.asset(R.image.ic_tabbar_addgrievance_blue),
                  label: ""),
            ],
            currentIndex: currentPage,
            onTap: (index) {
              pageController.animateToPage(index,
                  duration: Duration(milliseconds: 400), curve: Curves.linear);

              setState(() {
                currentPage = index;
                isSearching = false;
              });
            },
          ),
          decoration: BoxDecoration(
              color: Color(0xFFF3F6FE),
              border: Border(top: BorderSide(color: R.color.dark_white))),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: CircularGradientButton(
            child: SvgPicture.asset(currentPage == 2
                ? R.image.ic_tabbar_services_white
                : R.image.ic_tabbar_services_grey),
            callback: currentPage == 2
                ? null
                : () {
                    pageController.animateToPage(2,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.linear);
                    setState(() {
                      currentPage = 2;
                      isSearching = false;
                    });
                  },
            gradient: currentPage == 2
                ? BlueGradient()
                : LinearGradient(
                    colors: [Color(0xFFF3F6FE), Color(0xFFF3F6FE)],
                    begin: Alignment.bottomLeft,
                    end: Alignment.centerRight),
            shadowColor: Gradients.rainbowBlue.colors.last.withOpacity(0.5),
          ),
          onPressed: null,
        ),
      ),
      leftChild: Material(
        child: Container(
          padding: EdgeInsets.only(top: 50),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: CustomCircleAvatar(
                  child: Image.asset(R.image.avatar),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: R.color.dark_white,
                        blurRadius: 25,
                        spreadRadius: 0,
                        offset: Offset(0, 1)),
                    BoxShadow(
                        color: R.color.dark_black.withAlpha(50),
                        blurRadius: 25,
                        spreadRadius: 0,
                        offset: Offset(0, 1))
                  ]),
                ),
                margin: EdgeInsets.only(left: 20),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  'User',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: R.color.black,
                      fontSize: 18),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, bottom: 35),
                child: Text(
                  '',
                  style: TextStyle(color: R.color.gray, fontSize: 14),
                ),
              ),
              Expanded(child: leftMenu(context)),
            ],
          ),
        ),
      ),
    );
  }
}
