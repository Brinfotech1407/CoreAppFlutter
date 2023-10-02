import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mspmis/helpers/DatabaseHelper.dart';
import 'package:mspmis/model/productive_measure_model.dart';
import 'package:mspmis/utils/utils.dart';

class GroupementSuiviPage extends StatefulWidget {
  GroupementSuiviPage({Key key, this.groupement}) : super(key: key);

  final GroupementModel groupement;

  @override
  State<GroupementSuiviPage> createState() => _GroupementSuiviPageState();
}

class _GroupementSuiviPageState extends State<GroupementSuiviPage> {
  ValueNotifier<int> stepIndex = ValueNotifier(1);

  final TextEditingController soldeCumuleController = TextEditingController();
  final TextEditingController soldeActuelController = TextEditingController();
  final TextEditingController soldeCumule1Controller = TextEditingController();
  final TextEditingController soldeActuel1Controller = TextEditingController();
  final TextEditingController nombredController = TextEditingController();
  final TextEditingController pretsCreditsController = TextEditingController();
  final TextEditingController membresActifsController = TextEditingController();
  final TextEditingController membresExclusController = TextEditingController();
  final TextEditingController subventionsRecuesController =
      TextEditingController();
  final TextEditingController totalMontantSubentionController =
      TextEditingController();
  final TextEditingController activitesProductivesController =
      TextEditingController();

  @override
  void initState() {
    clearAllControllers();
    super.initState();
  }

  void clearAllControllers() {
    soldeActuelController.clear();
    soldeActuel1Controller.clear();
    soldeCumuleController.clear();
    soldeCumule1Controller.clear();
    nombredController.clear();
    pretsCreditsController.clear();
    membresActifsController.clear();
    membresExclusController.clear();
    subventionsRecuesController.clear();
    totalMontantSubentionController.clear();
    activitesProductivesController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final wB = MediaQuery.of(context).size.width - 10;

    return GestureDetector(
      onTap: () {
        //FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        /**/
        appBar: MainAppBar(
            context: context,
            title: TitleAppBarWhite(title: 'Suivi Groupement CGC RANDA'),
            leading: ButtonBackWhite(context)),
        body: Container(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: ValueListenableBuilder(
            valueListenable: stepIndex,
            builder: (context, value, child) {
              return SingleChildScrollView(
                /*keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,*/
                reverse: true,
                child: Expanded(
                  child: Column(
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
                                padding:
                                    const EdgeInsets.fromLTRB(8.0, 16, 8.0, 16),
                                child: Column(children: <Widget>[
                                  formHeaderView('Step 1'),
                                  InkWell(
                                    child: InputWidget(
                                        hintText: 'Solde Cumule Epargne',
                                        controller: soldeCumuleController),
                                    onTap: () {},
                                  ),
                                  InkWell(
                                    child: InputWidget(
                                        hintText: 'Solde Actuel Epargne',
                                        controller: soldeActuelController),
                                    onTap: () {},
                                  ),
                                  InkWell(
                                    child: InputWidget(
                                        hintText: 'Solde Cumule Epargne',
                                        controller: soldeCumule1Controller),
                                    onTap: () {},
                                  ),
                                  InkWell(
                                    child: InputWidget(
                                        hintText: 'Solde Actuel Epargne',
                                        controller: soldeActuel1Controller),
                                    onTap: () {},
                                  ),
                                  InkWell(
                                    child: InputWidget(
                                        hintText: 'Nombre d\'epargnes',
                                        controller: nombredController),
                                    onTap: () {},
                                  ),
                                  InkWell(
                                    child: InputWidget(
                                        hintText: '# Prets/Credits',
                                        controller: pretsCreditsController),
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
                                            hintText: '# Membres Actifs',
                                            controller:
                                                membresActifsController),
                                        onTap: () {},
                                      ),
                                      InkWell(
                                        child: InputWidget(
                                            hintText: '# Membres Exclus',
                                            controller:
                                                membresExclusController),
                                        onTap: () {},
                                      ),
                                      InkWell(
                                        child: InputWidget(
                                            hintText: '# Subventions recues',
                                            controller:
                                                subventionsRecuesController),
                                        onTap: () {},
                                      ),
                                      InkWell(
                                        child: InputWidget(
                                            hintText: 'Total Montant Subention',
                                            controller:
                                                totalMontantSubentionController),
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
                                              hintText:
                                                  '# Activites Productives creees',
                                              controller:
                                                  activitesProductivesController),
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
                            onUpdateDB(context);

                            //onPressHandle();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /**
   * Container(
      child: button(
      width: 50,
      text: getTextOfButton(),
      onPressed: () {
      onUpdateDB();

      //onPressHandle();
      }),
      )
   */

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
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
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

  Widget InputWidget({
    TextEditingController controller,
    String hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 8, right: 8),
      child: TextField(
        controller: controller,
        style: inputTextStyle(),
        keyboardType: TextInputType.number,
        onSubmitted: (value) {
          FocusScope.of(context).nextFocus();
        },
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Colors.blueGrey.shade200,
            ),
            borderRadius: BorderRadius.circular(200),
          ),
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.blueGrey.shade200,
            ),
            borderRadius: BorderRadius.circular(200),
          ),
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
        ),
      ),
    );
  }

  TextStyle inputTextStyle() =>
      const TextStyle(fontSize: 16, color: Colors.black);

  TextStyle hintStyle() => const TextStyle(fontSize: 16, color: Colors.grey);

  String getTextOfButton() {
    /*  if (stepIndex.value == 1) {
      return "Step 2";
    } else if (stepIndex.value == 2) {
      return "Step 3";
    }*/

    return 'Actualiser';
  }

  Future<void> onUpdateDB(BuildContext context) async {
    int actucalSaving = int.parse(soldeActuelController.text.toString().trim());
    int cumuelSaving = int.parse(soldeCumuleController.text.toString().trim());
    int totalSaving = int.parse(soldeCumule1Controller.text.toString().trim());
    int totalNewMemberActif =
        int.parse(soldeActuel1Controller.text.toString().trim());
    int excludedMember = int.parse(nombredController.text.toString().trim());
    int totalMember = int.parse(pretsCreditsController.text.toString().trim());
    int loanCumulatedActual =
        int.parse(membresActifsController.text.toString().trim());
    int totalNewLoans =
        int.parse(membresExclusController.text.toString().trim());
    int totalGrantsReceived =
        int.parse(subventionsRecuesController.text.toString().trim());
    int totalAmountReceive =
        int.parse(totalMontantSubentionController.text.toString().trim());
    int totalProductivitesActivityCreated =
        int.parse(activitesProductivesController.text.toString().trim());

    int result = await DatabaseHelper.instance.updateGroupmentId(
      soldeCumulatedSaving: cumuelSaving,
      solde_actual_saving: actucalSaving,
      total_saving: totalSaving,
      total_new_members_actif: totalNewMemberActif,
      total_excluded_members: excludedMember,
      total_members: totalMember,
      loan_cumulated_actual: loanCumulatedActual,
      total_new_loans: totalNewLoans,
      total_grants_received: totalGrantsReceived,
      total_grant_amount: totalAmountReceive,
      total_productives_activities_created: totalProductivitesActivityCreated,
      groupmentID: widget.groupement.id,
      groupement_activity_flag: 1,
    );

    if (result >= 1) {
      Flushbar(
        title: "Groupment",
        message: "Groupment Data Updated Successfully",
        duration: Duration(seconds: 3),
      ).show(context);

      clearAllControllers();

    } else {
      Flushbar(
        title: "Groupment",
        message: "Groupment Data Updated Failed,Something went wrong",
        duration: Duration(seconds: 3),
      ).show(context);
    }
  }

}
