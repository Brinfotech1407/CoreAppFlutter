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
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: ValueListenableBuilder(
          valueListenable: stepIndex,
          builder: (context, value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Card(
                        color: Colors.white,
                        margin: const EdgeInsets.all(4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 1,
                        //margin: EdgeInsets.only(top: 8),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0,16,8.0,16),
                          child: Column(children: <Widget>[
                            formHeaderView('Step 1'),
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
                              child: InputWidget(
                                  hint: '# Prets/Credits', bottom: 15),
                              onTap: () {},
                            ),
                          ]),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                            margin: const EdgeInsets.all(4),
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 1,

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: <Widget>[
                                formHeaderView('Step 2'),
                                InkWell(
                                  child: InputWidget(
                                      hint: '# Membres Actifs', bottom: 15),
                                  onTap: () {},
                                ),
                                InkWell(
                                  child: InputWidget(
                                      hint: '# Membres Exclus', bottom: 15),
                                  onTap: () {},
                                ),
                                InkWell(
                                  child: InputWidget(
                                      hint: '# Subventions recues',
                                      bottom: 15),
                                  onTap: () {},
                                ),
                                InkWell(
                                  child: InputWidget(
                                      hint: 'Total Montant Subention',
                                      bottom: 15),
                                  onTap: () {},
                                ),
                              ]),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Card(
                            margin: const EdgeInsets.all(4),
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  formHeaderView('Step 3'),
                                  InkWell(
                                    child: InputWidget(
                                        hint:
                                        '# Activites Productives creees',
                                        bottom: 15),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Padding formHeaderView(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              color: Colors.blueGrey,
              margin: const EdgeInsets.only(left: 12, right: 12),
              height: 1,
            ),
          ),
          Text(title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          Expanded(
            child: Container(
              color: Colors.blueGrey,
              margin: const EdgeInsets.only(left: 12, right: 12),
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  String getTextOfButton() {
  /*  if (stepIndex.value == 1) {
      return "Step 2";
    } else if (stepIndex.value == 2) {
      return "Step 3";
    }*/

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


/**
 *
 */
