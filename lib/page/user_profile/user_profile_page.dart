import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/utils/utils.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CustomCircleAvatar(
                  child: Image.asset(
                    R.image.avatar,
                    fit: BoxFit.fill,
                  ),
                  size: 120),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'Alexander Wolfe',
                  style: TextStyle(
                      color: R.color.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Container(
                  height: 170,
                  child: Card(
                    child: GridView.count(
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      crossAxisCount: 3,
                      children: <Widget>[
                        _ItemGoal(0),
                        _ItemGoal(1),
                        _ItemGoal(2),
                        _ItemGoal(3),
                        _ItemGoal(4),
                        _ItemGoal(5),
                      ],
                    ),
                  ),
                ),
              ),
              _ButtonDetail(
                  image: SvgPicture.asset(R.image.ic_goals),
                  text: 'Goal Settings',
                  onTap: () {
                    Navigator.of(context).pushNamed(RouterName.GOAL_SETTING);
                  }),
              _ButtonDetail(
                  image: SvgPicture.asset(R.image.ic_doctor_fav),
                  text: 'Doctor Favorites',
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(RouterName.DOCTOR_FAVORITES);
                  }),
              _ButtonDetail(
                  image: SvgPicture.asset(R.image.ic_personal_info),
                  text: 'Personal Information',
                  onTap: () {
                    Navigator.of(context).pushNamed(RouterName.INSURRANCE);
                  })
            ],
          ),
        ),
      ),
    );
  }
}

Widget _ItemGoal(int pos) => Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(border: _BorderGoal(pos)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'GOAL',
            style: TextStyle(color: R.color.grey, fontSize: 18),
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: '108',
                  style: TextStyle(color: R.color.black, fontSize: 24)),
              TextSpan(
                  text: ' bmp',
                  style: TextStyle(color: R.color.grey, fontSize: 12))
            ])),
          )
        ],
      ),
    );

Border _BorderGoal(int pos) {
  switch (pos) {
    case 0:
      return Border(
          right: BorderSide(color: R.color.dark_white),
          bottom: BorderSide(color: R.color.dark_white));
    case 1:
      return Border(
          right: BorderSide(color: R.color.dark_white),
          bottom: BorderSide(color: R.color.dark_white));
    case 2:
      return Border(bottom: BorderSide(color: R.color.dark_white));
    case 3:
      return Border(
        right: BorderSide(color: R.color.dark_white),
      );
    case 4:
      return Border(
        right: BorderSide(color: R.color.dark_white),
      );
  }
}

Widget _ButtonDetail({Widget image, String text, Function onTap}) => Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 32),
      child: InkWell(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 3,
          child: Container(
            padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
            child: Row(
              children: <Widget>[
                image,
                Container(
                  margin: EdgeInsets.only(left: 25, right: 25),
                  width: 1,
                  height: 30,
                  color: R.color.dark_white,
                ),
                Expanded(
                    child: Text(
                  text,
                  style: TextStyle(color: R.color.black, fontSize: 18),
                )),
                Container(
                  child: SvgPicture.asset(R.image.ic_arrow_right),
                )
              ],
            ),
          ),
        ),
      ),
    );
