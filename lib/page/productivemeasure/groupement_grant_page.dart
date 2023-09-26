import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/generated/i18n.dart';
import 'package:mspmis/utils/utils.dart';
import 'package:mspmis/model/productive_measure_model.dart';
import 'package:mspmis/helpers/DatabaseHelper.dart';
import 'package:badges/badges.dart' as badges;

class GroupementGrantPage extends StatefulWidget {
  GroupementGrantPage({Key key, this.groupement}) : super(key: key);
  final GroupementModel groupement;
  List<GrantModel> _grants ;
  @override
  _GroupementGrantPageState createState() {
    return _GroupementGrantPageState();
  }
}

class _GroupementGrantPageState extends State<GroupementGrantPage> {
  bool isSearching = false;
  FocusNode _focusSearch = FocusNode();

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    List<GrantModel> result =
    await DatabaseHelper.instance.fetchGrants(widget.groupement.id);

    setState(() {
      widget._grants = result;
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
              : TitleAppBarWhite(title: S.of(context).title_groupement_grant),
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
          itemBuilder: (context, pos) => _ItemGrantMember(
              context,
              widget._grants[pos]
            ),
          itemCount: widget._grants == null
              ? 0
              : widget._grants.length,
        ),
      ),
    );
  }
}

Widget _ItemGrantMember(BuildContext context, GrantModel grant ) => Container(
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
                SvgPicture.asset(R.image.ic_tabbar_addproductivemeasure_blue),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'Projet Subvention' + grant.sub_project_id.toString(),
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
                  'Montant Subvention',
                  style: TextStyle(color: R.color.grey, fontSize: 16),
                ),
                Padding(
                  padding: EdgeInsets.zero,
                  child: Text(
                    grant.grant_amount.toString(),
                    style: TextStyle(color: R.color.black, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Date Allocation',
                          style:
                          TextStyle(color: R.color.grey, fontSize: 16),
                        ),
                      ),
                      Expanded(
                          child: Text(
                            'Date Transfert',
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
                            grant.date_granted,
                            style:
                            TextStyle(color:  R.color.blue, fontSize: 18),
                          ),
                      ),
                      Expanded(
                          child: Text(
                            grant.date_transferred,
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
                          'Date Retrait',
                          style:
                          TextStyle(color: R.color.grey, fontSize: 16),
                        ),
                      ),
                      Expanded(
                          child: Text(
                            'A financer une (des) activite(s) productive(s) ?',
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
                         grant.date_debited,
                          style:
                          TextStyle(color: R.color.black, fontSize: 18),
                        ),
                      ),
                      Expanded(
                          child: Text(
                            'Oui',
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
