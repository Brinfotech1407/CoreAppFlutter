import 'package:flutter/material.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/utils/utils.dart';

class GroupementSuiviPage extends StatefulWidget {
  @override
  State<GroupementSuiviPage> createState() => _GroupementSuiviPageState();
}

class _GroupementSuiviPageState extends State<GroupementSuiviPage> {
  ValueNotifier<int> stepIndex = ValueNotifier(1);

  @override
  Widget build(BuildContext context) {
    final wB = MediaQuery.of(context).size.width - 10;
    print('Building WB ${stepIndex.value}');
    return Scaffold(
      appBar: MainAppBar(
          context: context,
          title: TitleAppBarWhite(title: 'Suivi Groupement CGC RANDA'),
          leading: ButtonBackWhite(context)),
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
        child: Column(
          children: [
            ValueListenableBuilder<int>(
              builder: (BuildContext context, int value, Widget child) {
                return Column(
                  children: [
                    if (value == 1) ...<Widget>[
                      Column(children: <Widget>[
                        InkWell(
                          child: InputWidget(
                              hint: 'Solde Cumule Epargne', bottom: 15),
                          onTap: () {},
                        ),
                        InkWell(
                          child: InputWidget(
                              hint: 'Solde Actuel Epargne', bottom: 15),
                          onTap: () {},
                        ),
                        InkWell(
                          child: InputWidget(
                              hint: 'Solde Cumule Epargne', bottom: 15),
                          onTap: () {},
                        ),
                        InkWell(
                          child: InputWidget(
                              hint: 'Solde Actuel Epargne', bottom: 15),
                          onTap: () {},
                        ),
                        InkWell(
                          child: InputWidget(
                              hint: 'Nombre d\'epargnes', bottom: 15),
                          onTap: () {},
                        ),
                        InkWell(
                          child:
                              InputWidget(hint: '# Prets/Credits', bottom: 15),
                          onTap: () {},
                        ),
                      ]),
                    ] else if (value == 2) ...<Widget>[
                      Column(children: <Widget>[
                        InkWell(
                          child:
                              InputWidget(hint: '# Membres Actifs', bottom: 15),
                          onTap: () {},
                        ),
                        InkWell(
                          child:
                              InputWidget(hint: '# Membres Exclus', bottom: 15),
                          onTap: () {},
                        ),
                        InkWell(
                          child: InputWidget(
                              hint: '# Subventions recues', bottom: 15),
                          onTap: () {},
                        ),
                        InkWell(
                          child: InputWidget(
                              hint: 'Total Montant Subention', bottom: 15),
                          onTap: () {},
                        ),
                      ]),
                    ] else if (value == 3) ...<Widget>[
                      InkWell(
                        child: InputWidget(
                            hint: '# Activites Productives creees', bottom: 15),
                        onTap: () {},
                      ),
                    ],
                    Container(
                      child: button(
                          width: 50,
                          text: getTextOfButton(),
                          onPressed: () {
                            if (stepIndex.value != 3) {
                              stepIndex.value = stepIndex.value + 1;
                            }

                            //onPressHandle();
                          }),
                    )
                  ],
                );
              },
              valueListenable: stepIndex,
            ),
          ],
        ),
      ),
    );
  }

  String getTextOfButton() {
    if (stepIndex.value == 1) {
      return "Step 2";
    } else if (stepIndex.value == 2) {
      return "Step 3";
    }

    return 'Actualiser';
  }

  Widget _ItemGoal(String pos, int t) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              pos,
              style: TextStyle(color: R.color.grey, fontSize: 17),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: t.toString(),

                    style: TextStyle(color: R.color.black, fontSize: 24))
              ])),
            )
          ],
        ),
      );
}
