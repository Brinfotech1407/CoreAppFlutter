import 'package:flutter/material.dart';

import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/generated/i18n.dart';
import 'package:mspmis/utils/utils.dart';

class FindBeneficiaryPage extends StatefulWidget {
  @override
  _FindBeneficiaryPageState createState() {
    return _FindBeneficiaryPageState();
  }
}

class _FindBeneficiaryPageState extends State<FindBeneficiaryPage>
    with AutomaticKeepAliveClientMixin<FindBeneficiaryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MainAppBar(
        context: context,
        leading: ButtonBackWhite(context),
        title: TitleAppBarWhite(title: S.of(context).title_find_beneficiary),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 30),
        child: Column(
          children: <Widget>[
            Container(
                  ),
            InputWidget(
              hint: S.of(context).hint_beneficiary_name,
              bottom: 20,
              onTap: () {},
            ),
            InputWidget(
              hint: S.of(context).hint_program,
              bottom: 20,
              onTap: () {},
            ),
            InputWidget(
              hint: S.of(context).hint_project,
              bottom: 20,
              onTap: () {},
            ),
            InputWidget(
              hint: S.of(context).hint_phase,
              bottom: 20,
              onTap: () {},
            ),
            Container(
              child: button(
                  width: 250,
                  text: S.of(context).btn_find.toUpperCase(),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(RouterName.BENEFICIARIES_LIST);
                  }),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
