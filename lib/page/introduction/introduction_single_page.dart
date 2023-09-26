import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mspmis/contanst/contanst.dart';

class IntroductionSinglePage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  IntroductionSinglePage({this.image, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          margin: EdgeInsets.only(bottom: 80),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SvgPicture.asset(image),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Text(
                  title.toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: R.color.black),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 50, right: 50, top: 30),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: R.color.grey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
