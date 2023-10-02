// #4e6ce3
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/generated/i18n.dart';
import 'package:mspmis/model/productive_measure_model.dart';
import 'package:mspmis/page/productivemeasure/groupement_grant_page.dart';
import 'package:mspmis/page/productivemeasure/groupement_member_page.dart';
import 'package:mspmis/page/productivemeasure/groupement_productive_activity_page.dart';
import 'package:mspmis/page/productivemeasure/groupement_suivi_page.dart';
import 'package:mspmis/utils/utils.dart';

class GroupementsPage extends StatefulWidget {
  GroupementsPage({Key key, this.groupement}) : super(key: key);
  final GroupementModel groupement;

  @override
  _GroupementsPageState createState() {
    return _GroupementsPageState();
  }
}

class _GroupementsPageState extends State<GroupementsPage> {
  bool _isChecked;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    setState(() {
      _isChecked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final wB = MediaQuery.of(context).size.width - 40;
    return Scaffold(
      appBar: MainAppBar(
          context: context,
          title:
              TitleAppBarWhite(title: S.of(context).title_groupement_profile),
          leading: ButtonBackWhite(context)),
      body: Container(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Positioned(
              top: 10,
              right: 50,
              child: InkWell(
                child: Container(
                    child: badges.Badge(
                  badgeColor: Colors.green,
                  shape: badges.BadgeShape.square,
                  // borderRadius: 20,
                  toAnimate: false,
                  badgeContent: Text(widget.groupement.type_groupement_id,
                      style: const TextStyle(color: Colors.white)),
                )),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 25),
              child: Text(
                widget.groupement.label,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: R.color.black),
              ),
            ),
            Container(
              height: 150,
              width: wB,
              decoration: ShadowDecorationWhite(),
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(child: _ItemGoal('# Members', 0)),
                            Expanded(child: _ItemGoal('Solde Epargne', 0))
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(child: _ItemGoal('# Beneficiaires', 0)),
                            Expanded(child: _ItemGoal('# Subventions', 0))
                          ],
                        ),
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Divider(
                      color: R.color.dark_white,
                      indent: 20,
                      endIndent: 20,
                    ),
                  ),
                  Positioned(
                    left: wB / 2 - 10,
                    height: 150,
                    child: VerticalDivider(
                      color: R.color.dark_white,
                      indent: 20,
                      endIndent: 20,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30, bottom: 45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton.extended(
                      heroTag: '3',
                      label: Text(
                        S.of(context).btn_suivi.toUpperCase(),
                        style: TextStyle(color: R.color.white, fontSize: 12),
                      ),
                      backgroundColor: R.color.blue,
                      icon: const Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _isChecked == false
                            ? showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    SimpleDialogExample(),
                              )
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GroupementSuiviPage(
                                      groupement: widget.groupement),
                                ),
                              );
                        /*Navigator.of(context)
                            .pushNamed(RouterName.ADD_SUIVI_GROUPEMENT);*/
                      }),
                  FloatingActionButton.extended(
                      heroTag: '5',
                      label: Text(
                        S.of(context).btn_add_payment.toUpperCase(),
                        style: TextStyle(color: R.color.white, fontSize: 12),
                      ),
                      backgroundColor: R.color.blue,
                      icon: const Icon(
                        Icons.monetization_on,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _isChecked == true
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => null,
                                ),
                              )
                            : showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    SimpleDialogExample(),
                              );
                      }),
                  FloatingActionButton.extended(
                      heroTag: '6',
                      label: Text(
                        S.of(context).btn_add_grievance.toUpperCase(),
                        style: TextStyle(color: R.color.white, fontSize: 12),
                      ),
                      backgroundColor: R.color.blue,
                      icon: const Icon(
                        Icons.add_comment,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(),
                        );
                      }),
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _ButtonDetail(
                      image:
                          SvgPicture.asset(R.image.ic_tabbar_groupement_blue),
                      text: S.of(context).lbl_suivi_groupement,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GroupementMemberPage(
                                groupement: widget.groupement),
                          ),
                        );
                      }),
                  _ButtonDetail(
                      image:
                          SvgPicture.asset(R.image.ic_tabbar_subvention_blue),
                      text: 'Suivi ' + S.of(context).lbl_subvention_ip,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GroupementGrantPage(
                                groupement: widget.groupement),
                          ),
                        );
                      }),
                  _ButtonDetail(
                      image: SvgPicture.asset(R.image.ic_tabbar_activity_blue),
                      text: 'Suivi ' + S.of(context).lbl_activity_ip,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                GroupementProductiveActivityPage(
                                    groupement: widget.groupement),
                          ),
                        );
                      }),
                  _ButtonDetail(
                      image:
                          SvgPicture.asset(R.image.ic_tabbar_addgrievance_blue),
                      text: 'Suivi ' +
                          S.of(context).lbl_beneficiary_grievance_transaction,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => null,
                          ),
                        );
                      }),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget _ButtonDetail({Widget image, String text, Function onTap}) => InkWell(
        onTap: onTap,
        child: Container(
          decoration: ShadowDecorationWhite(),
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 32),
          padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
          child: Row(
            children: <Widget>[
              image,
              Container(
                margin: const EdgeInsets.only(left: 25, right: 25),
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
      );

  Widget _ItemGoal(String msg, int pos) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              msg,
              style: TextStyle(color: R.color.grey, fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: pos.toString(),
                    style: TextStyle(color: R.color.black, fontSize: 24))
              ])),
            )
          ],
        ),
      );
}
