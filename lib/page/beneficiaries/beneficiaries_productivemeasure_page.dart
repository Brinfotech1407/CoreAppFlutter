import 'package:mspmis/model/beneficiary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/generated/i18n.dart';
import 'package:mspmis/utils/utils.dart';
import 'package:badges/badges.dart' as badges;
import 'package:mspmis/model/productive_measure_model.dart';
import 'package:mspmis/helpers/DatabaseHelper.dart';

class BenefciariesProductiveMeasurePage extends StatefulWidget {
  BenefciariesProductiveMeasurePage({Key key, this.beneficiary}) : super(key: key);
  final BeneficiaryModel beneficiary;
  List<ProductiveActivityModel> _productives_activities ;
  List<GrantModel> _grants ;
  List<Map<String, dynamic>> _groupements ;

  @override
  _BenefciariesProductiveMeasureState createState() {
    return _BenefciariesProductiveMeasureState();
  }
}

class _BenefciariesProductiveMeasureState extends State<BenefciariesProductiveMeasurePage> {
  bool isSearching = false;
  FocusNode _focusSearch = FocusNode();

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {

    List<ProductiveActivityModel> pas =
    await DatabaseHelper.instance.fetchProductivesActivitiesForBeneficiary(widget.beneficiary.id);

    List<GrantModel> grants =
    await DatabaseHelper.instance.fetchGrantsForBeneficiary(widget.beneficiary.id);

    List<Map<String, dynamic>> groups =
    await DatabaseHelper.instance.fetchMembership(widget.beneficiary.id);

    setState(() {
      widget._productives_activities = pas;
      widget._grants = grants;
      widget._groupements = groups;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
          context: context,
          leading: ButtonBackWhite(context),
          title: isSearching
              ? Container(
            padding: EdgeInsets.only(left: 10),
            width: 300,
            height: 30,
            child: TextFormField(
              focusNode: _focusSearch,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle:
                TextStyle(color: Color(0xFF969696), fontSize: 14),
                labelStyle: TextStyle(color: R.color.black, fontSize: 14),
                suffixIcon: Icon(
                  Icons.search,
                  color: Color(0xFF969696),
                ),
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(200)),
          )
              : TitleAppBarWhite(
              title: S.of(context).title_beneficairies_productivemeasure),
          actions: isSearching
              ? []
              : [
            IconButton(
                icon: SvgPicture.asset(R.image.ic_search),
                onPressed: () {
                  setState(() {
                    isSearching = true;
                  });
                })
          ]),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child:

          ListView(
            children: <Widget>[
              widget._groupements == null ? Container() : _ItemGroupement(context,widget._groupements[0]),
              widget._grants == null ? Container() : _ItemSubvention(context,widget._grants[0]),
              widget._productives_activities == null ? Container() :_ItemActivityProductive(context,widget._productives_activities[0])
              ],
          ),



      ),
    );
  }
}

Widget _ItemGroupement(BuildContext context,Map<String, dynamic> group) =>
    Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color(0xFFF3F6FE),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8))),
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset(R.image.ic_tabbar_groupement_blue),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        group['label'],
                        style: TextStyle(
                            color: R.color.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),

              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(
                                S.of(context).lbl_groupement_label,
                                style: TextStyle(color: R.color.grey, fontSize: 16),
                              )),
                          Expanded(
                              child: Text(
                                S.of(context).lbl_type_groupement_label,
                                style: TextStyle(color: R.color.grey, fontSize: 16),
                              )),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Text(
                                  group['label'],
                                  style:
                                  TextStyle(color: R.color.black, fontSize: 18),
                                )),
                            Expanded(
                                child: Text(
                                  group['type_groupement_id'].toString(),
                                  style:
                                  TextStyle(color: R.color.black, fontSize: 18),
                                ))
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              S.of(context).lbl_date_adhesion_groupement,
                              style:
                              TextStyle(color: R.color.grey, fontSize: 16),
                            ),
                          ),
                          Expanded(
                              child: Text(
                                S.of(context).lbl_statut_membership_groupement,
                                style: TextStyle(color: R.color.grey, fontSize: 16),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                             group['adhesion_at'],
                              style:
                              TextStyle(color: R.color.black, fontSize: 18),
                            ),
                          ),
                          Expanded(
                              child: Text(
                              group['groupement_beneficiary_flag'].toString(),
                                style:
                                TextStyle(color: R.color.black, fontSize: 18),
                              ))
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: button(
                                width: 10,
                                text: S
                                    .of(context)
                                    .btn_membership_to_be_updated
                                    .toUpperCase(),



                          ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 10,
            right: 25,
            child: InkWell(
              child: Container(
                  child: badges.Badge(
                    badgeColor: Colors.red
                       ,
                    shape: badges.BadgeShape.square,
                    // borderRadius: 20,
                    toAnimate: false,
                    badgeContent: Text(
                       "Non actualisee",
                        style: TextStyle(color: Colors.white)),
                  )),
            ),
          )
        ],
      ),
    );

Widget _ItemSubvention(BuildContext context, GrantModel grant) =>
    Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color(0xFFF3F6FE),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8))),
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset(R.image.ic_tabbar_subvention_blue),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Subvention',
                        style: TextStyle(
                            color: R.color.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),

              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(
                                "Projet Subvention",
                                style: TextStyle(color: R.color.grey, fontSize: 16),
                              )),
                          Expanded(
                              child: Text(
                                S.of(context).lbl_type_subvention_label,
                                style: TextStyle(color: R.color.grey, fontSize: 16),
                              )),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Text(
                                  grant.sub_project_id.toString(),
                                  style:
                                  TextStyle(color: R.color.black, fontSize: 18),
                                )),
                            Expanded(
                                child: Text(
                                  grant.type_demandeur,
                                  style:
                                  TextStyle(color: R.color.black, fontSize: 18),
                                ))
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              S.of(context).lbl_date_octroi_subvention,
                              style:
                              TextStyle(color: R.color.grey, fontSize: 16),
                            ),
                          ),
                          Expanded(
                              child: Text(
                                S.of(context).lbl_montant_subvention,
                                style: TextStyle(color: R.color.grey, fontSize: 16),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              grant.date_granted,
                              style:
                              TextStyle(color: R.color.black, fontSize: 18),
                            ),
                          ),
                          Expanded(
                              child: Text(
                               grant.grant_amount.toString(),
                                style:
                                TextStyle(color: R.color.black, fontSize: 18),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Date Transfert',
                              style:
                              TextStyle(color: R.color.grey, fontSize: 16),
                            ),
                          ),
                          Expanded(
                              child: Text(
                               'Date Retrait',
                                style: TextStyle(color: R.color.grey, fontSize: 16),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              grant.date_transferred,
                              style:
                              TextStyle(color: R.color.black, fontSize: 18),
                            ),
                          ),
                          Expanded(
                              child: Text(
                                grant.date_debited,
                                style:
                                TextStyle(color: R.color.black, fontSize: 18),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: button(
                              width: 10,
                              text: S
                                  .of(context)
                                  .btn_membership_to_be_updated
                                  .toUpperCase(),



                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 10,
            right: 25,
            child: InkWell(
              child: Container(
                  child: badges.Badge(
                    badgeColor: Colors.red
                    ,
                    shape: badges.BadgeShape.square,
                    // borderRadius: 20,
                    toAnimate: false,
                    badgeContent: Text(
                        "Non actualisee",
                        style: TextStyle(color: Colors.white)),
                  )),
            ),
          )
        ],
      ),
    );

Widget _ItemActivityProductive(BuildContext context, ProductiveActivityModel pa) =>
    Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color(0xFFF3F6FE),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8))),
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset(R.image.ic_tabbar_activity_blue),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Activite Productive',
                        style: TextStyle(
                            color: R.color.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),

              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(
                                'Type Financement',
                                style: TextStyle(color: R.color.grey, fontSize: 16),
                              )),
                          Expanded(
                              child: Text(
                                S.of(context).lbl_nature_activity_productive_label,
                                style: TextStyle(color: R.color.grey, fontSize: 16),
                              )),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Text(
                                  pa.type_financement,
                                  style:
                                  TextStyle(color: R.color.black, fontSize: 18),
                                )),
                            Expanded(
                                child: Text(
                                  pa.nature_activite,
                                  style:
                                  TextStyle(color: R.color.black, fontSize: 18),
                                ))
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              S.of(context).lbl_type_activity_productive,
                              style:
                              TextStyle(color: R.color.grey, fontSize: 16),
                            ),
                          ),
                          Expanded(
                              child: Text(
                                S.of(context).lbl_montant_investi,
                                style: TextStyle(color: R.color.grey, fontSize: 16),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              pa.type_activite,
                              style:
                              TextStyle(color: R.color.black, fontSize: 18),
                            ),
                          ),
                          Expanded(
                              child: Text(
                                pa.amount.toString(),
                                style:
                                TextStyle(color: R.color.black, fontSize: 18),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Date Demarrage',
                              style:
                              TextStyle(color: R.color.grey, fontSize: 16),
                            ),
                          ),
                          Expanded(
                              child: Text(
                                'Status',
                                style: TextStyle(color: R.color.grey, fontSize: 16),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              pa.start_date,
                              style:
                              TextStyle(color: R.color.black, fontSize: 18),
                            ),
                          ),
                          Expanded(
                              child: Text(
                                pa.flag_productive_activity.toString(),
                                style:
                                TextStyle(color: R.color.black, fontSize: 18),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: button(
                              width: 10,
                              text: S
                                  .of(context)
                                  .btn_membership_to_be_updated
                                  .toUpperCase(),



                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 10,
            right: 25,
            child: InkWell(
              child: Container(
                  child: badges.Badge(
                    badgeColor: Colors.red
                    ,
                    shape: badges.BadgeShape.square,
                    // borderRadius: 20,
                    toAnimate: false,
                    badgeContent: Text(
                        "Non actualisee",
                        style: TextStyle(color: Colors.white)),
                  )),
            ),
          )
        ],
      ),
    );

