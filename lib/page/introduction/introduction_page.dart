import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mspmis/generated/i18n.dart';
import 'package:mspmis/utils/utils.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:provider/provider.dart';
import 'introduction_page_model.dart';
import 'introduction_single_page.dart';

class IntroductionPage extends StatelessWidget {
  PageController _pageController;
  GlobalKey _key = GlobalKey();
  final Max_Page = 4;

  static Widget ProviderPage() {
    return ChangeNotifierProvider<IntroductionPageModel>(
      create: (_) => IntroductionPageModel(),
      child: IntroductionPage(),
    );
  }

  static IntroductionPageModel of(BuildContext context) =>
      Provider.of<IntroductionPageModel>(context, );

  IntroductionPage() {
    _pageController = PageController();

    _pageController.addListener(() {
      IntroductionPage.of(_key.currentContext)
          .updatePage(_pageController.page.toInt());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _key,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          PageIndicatorContainer(
            child: PageView(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  IntroductionSinglePage(
                    image: R.image.ic_doctor,
                    title: S.of(context).title_intro1,
                    description: S.of(context).desc_intro1,
                  ),
                  IntroductionSinglePage(
                    image: R.image.ic_drugs,
                    title: S.of(context).title_intro2,
                    description: S.of(context).desc_intro2,
                  ),
                  IntroductionSinglePage(
                    image: R.image.ic_appoitment,
                    title: S.of(context).title_intro3,
                    description: S.of(context).desc_intro3,
                  ),
                  IntroductionSinglePage(
                    image: R.image.ic_appoitment,
                    title: S.of(context).title_intro4,
                    description: S.of(context).desc_intro4,
                  )
                ]),
            length: Max_Page,
            align: IndicatorAlign.bottom,
            shape: IndicatorShape.roundRectangleShape(size: Size(31, 4)),
            indicatorColor: Color(0xFFC8C8C8),
            padding: EdgeInsets.only(bottom: 80),
            indicatorSpace: 10,
            indicatorSelectorColor: R.color.blue,
          ),
          Visibility(
            visible: IntroductionPage.of(context).currentPage == Max_Page - 1,
            child: Positioned(
                bottom: 60,
                child: button(
                    text: S.of(context).btn_get_started.toUpperCase(),
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          RouterName.SIGN_IN, (Route<dynamic> route) => false);
                    })),
          ),
          Visibility(
              visible: IntroductionPage.of(context).currentPage < Max_Page - 1,
              child: Positioned(
                child: _buttonNext(onPressed: () {
                  _pageController.jumpToPage(_pageController.page.toInt() + 1);
                }),
                bottom: 55,
                right: 35,
              )),
          Visibility(
              visible: IntroductionPage.of(context).currentPage > 0 &&
                  IntroductionPage.of(context).currentPage < Max_Page - 1,
              child: Positioned(
                child: _buttonBack(onPressed: () {
                  _pageController.jumpToPage(_pageController.page.toInt() - 1);
                }),
                bottom: 55,
                left: 35,
              ))
        ],
      ),
    );
  }
}

Widget _buttonNext({Function onPressed}) => FloatingActionButton(
    onPressed: onPressed,
    child: Container(child: SvgPicture.asset(R.image.btn_next_intro)));

Widget _buttonBack({Function onPressed}) => FloatingActionButton(
  onPressed: onPressed,
  elevation: 0,
  child: SvgPicture.asset(R.image.btn_back_intro),
);
