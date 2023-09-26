import 'package:mspmis/page/beneficiaries/beneficiaries_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/generated/i18n.dart';
import 'package:mspmis/utils/item_beneficiaries_widget.dart';
import 'package:mspmis/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'beneficiaries_list_page_model.dart';

class BeneficiariesListPage extends StatefulWidget {
  static Widget ProviderPage() {
    return ChangeNotifierProvider<BeneficiariesListPageModel>(
      create: (_) => BeneficiariesListPageModel(),
      child: BeneficiariesListPage(),
    );
  }


  @override
  _BeneficiariesListPageState createState() {
    return _BeneficiariesListPageState();
  }
}

class _BeneficiariesListPageState extends State<BeneficiariesListPage>
    with AutomaticKeepAliveClientMixin<BeneficiariesListPage> {
  BeneficiariesListPageModel notifier;
  bool _isInAsyncCall = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isInAsyncCall = true;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final notifier = Provider.of<BeneficiariesListPageModel>(context);

    if (this.notifier != notifier) {
      this.notifier = notifier;
      //Direct API Call
      //Future.microtask(() => notifier.fetchData());
      //SQLite Call
      setState(() {
        if (!notifier.isFetching) _isInAsyncCall = false;
      });
      Future.microtask(() => notifier.fetchLocalData());
      setState(() {
        _isInAsyncCall = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    BeneficiariesListPageModel blockitem =
        Provider.of<BeneficiariesListPageModel>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MainAppBar(
        context: context,
        leading: ButtonBackWhite(context),
        title: TitleAppBarWhite(title: S.of(context).title_beneficiaries),
      ),
      body: ModalProgressHUD(
        child: Container(
          //padding: EdgeInsets.only(left: 30, right: 30),
          margin: EdgeInsets.only(left: 16, right: 16, top: 16),

          child: ListView.builder(
              itemCount: blockitem.getBeneficiariesList == null
                  ? 0
                  : blockitem.getBeneficiariesList.length,
              itemBuilder: (context, index) {
                return blockitem.getBeneficiariesList.isNotEmpty
                    ? Column(
                        children: <Widget>[
                          ItemBeneficiaryWidget(
                            beneficiary: blockitem.getBeneficiariesList[index],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BeneficiariesPage(
                                      beneficiary: blockitem
                                          .getBeneficiariesList[index]),
                                ),
                              );
                            },
                            onDelete: () {
                              notifier.removeAt(index);
                            },
                          ),
                        ],
                      )
                    : CircularProgressIndicator();
              }),
        ),

        inAsyncCall: _isInAsyncCall,
        // demo of some additional parameters
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
