import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/generated/i18n.dart';
import 'package:mspmis/utils/utils.dart';
import 'package:mspmis/model/productive_measure_model.dart';
import 'package:mspmis/helpers/DatabaseHelper.dart';
import 'package:badges/badges.dart' as badges;

class GroupementMemberPage extends StatefulWidget {
  GroupementMemberPage({Key key, this.groupement}) : super(key: key);
  final GroupementModel groupement;
  List<Map<String, dynamic>> _members ;
  @override
  _GroupementMemberPageState createState() {
    return _GroupementMemberPageState();
  }
}

class _GroupementMemberPageState extends State<GroupementMemberPage> {
  bool isSearching = false;
  FocusNode _focusSearch = FocusNode();

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    List<Map<String, dynamic>> result =
    await DatabaseHelper.instance.fetchMembers(widget.groupement.id);

    setState(() {
      widget._members = result;
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
              : TitleAppBarWhite(title: S.of(context).title_groupement_member),
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
        child: ListView.builder(
          itemBuilder: (context, pos) => _ItemGroupementMember(
              context,
              widget._members[pos]
            ),
          itemCount: widget._members == null
              ? 0
              : widget._members.length,
        ),
      ),
    );
  }
}

Widget _ItemGroupementMember(BuildContext context, Map<String, dynamic> member ) => Container(
  decoration: ShadowDecorationWhite(),
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
                SvgPicture.asset(R.image.ic_tabbar_profile_blue),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    member['name'],
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
                Text(
                  'Role',
                  style: TextStyle(color: R.color.grey, fontSize: 16),
                ),
                Padding(
                  padding: EdgeInsets.zero,
                  child: Text(
                    member['role'],
                    style: TextStyle(color: R.color.black, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Status',
                          style:
                          TextStyle(color: R.color.grey, fontSize: 16),
                        ),
                      ),
                      Expanded(
                          child: Text(
                            'Projet Beneficiaire',
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
                        child:
                          Text(
                            member['groupement_beneficiary_flag'] == 1 ? 'Actif' : 'Inactif',
                            style:
                            TextStyle(color: member['groupement_beneficiary_flag'] == 1 ? R.color.blue : R.color.grey, fontSize: 18),
                          ),
                      ),
                      Expanded(
                          child: Text(
                            'PITCH',
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
                          'Date Adhesion',
                          style:
                          TextStyle(color: R.color.grey, fontSize: 16),
                        ),
                      ),
                      Expanded(
                          child: Text(
                            'Date Sortie',
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
                          member['adhesion_at'],
                          style:
                          TextStyle(color: R.color.black, fontSize: 18),
                        ),
                      ),
                      Expanded(
                          child: Text(
                            member['terminaison_at'] == null ? '' : member['terminaison_at'],
                            style:
                            TextStyle(color: R.color.black, fontSize: 18),
                          ))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
      Positioned(
        top: 25,
        right: 25,
        child: InkWell(
          child: Container(
            child: SvgPicture.asset(R.image.ic_edit),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Color(0xFF416CE3).withAlpha(60),
                  blurRadius: 25,
                  offset: Offset(0, 2)),
              BoxShadow(
                  color: R.color.dark_black.withAlpha(50),
                  blurRadius: 25,
                  spreadRadius: -10,
                  offset: Offset(0, 2))
            ]),
          ),
        ),
      )
    ],
  ),
);
