import 'package:another_flushbar/flushbar.dart';
import 'package:mspmis/helpers/DatabaseHelper.dart';
import 'package:mspmis/model/productive_measure_model.dart';
import 'package:mspmis/model/program_model.dart';
import 'package:mspmis/page/beneficiaries/beneficiaries_list_page_model.dart';
import 'package:flutter/material.dart';

import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/generated/i18n.dart';
import 'package:mspmis/utils/utils.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:mspmis/model/beneficiary_model.dart';
import 'package:mspmis/model/project_model.dart';
import 'package:mspmis/model/supply_model.dart';
import 'package:mspmis/model/ounit_model.dart';
import 'package:mspmis/model/phase_model.dart';
import 'package:mspmis/model/sub_project_model.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  BeneficiariesListPageModel notifier;
  // manage state of modal progress HUD widget
  bool _isInAsyncCall = false;
  bool _isLoaded = false;
  ProgramModel _selectedProgram;
  ProjectModel _selectedProject;
  PhaseModel _selectedPhase;
  OunitModel _selectedDistrict;
  SupplyModel _selectedSite;

  List<ProgramModel> _programLists = <ProgramModel>[
    const ProgramModel(1, 'Programme PNSF'),
    const ProgramModel(9, 'Programme COVID19'),
    const ProgramModel(2, 'Programme ASERIVD')
  ];
  List<ProjectModel> _projectLists = <ProjectModel>[
    const ProjectModel(1, 'Projet PNSF PITCH'),
    const ProjectModel(13, 'Projet PNSF PROLIC'),
    const ProjectModel(3, 'Projet PITCH PAM'),
    const ProjectModel(9, 'Projet PITCH FSN'),
    const ProjectModel(4, 'Projet ASERIVD'),
    const ProjectModel(15, 'Projet PNSF SPECP')
  ];

  List<SubProjectModel> _sub_projectLists = <SubProjectModel>[
    const SubProjectModel(1, 'Projet Subvention PITCH'),
    const SubProjectModel(3, 'Projet Subvention SPECP')
  ];

  List<PhaseModel> _phaseLists = <PhaseModel>[
    const PhaseModel(14, 'Phase Intervention PNSF PAM 2019'),
    const PhaseModel(20, 'Phase Intervention PNSF PAM 2020'),
    const PhaseModel(15, 'Phase Intervention PNSF PITCH 2020'),
    const PhaseModel(22, 'Phase Intervention PNSF PITCH 2021'),
    const PhaseModel(17, 'Phase Intervention PNSF FSN 2020'),
    const PhaseModel(28, 'Phase Intervention PNSF PROLIC 2021'),
    const PhaseModel(35, 'Phase Intervention PNSF SPECP 2023')
  ];
  List<OunitModel> _ounitLists = <OunitModel>[
    const OunitModel(2, 'Djibouti'),
    const OunitModel(6, 'Arta'),
    const OunitModel(42, 'Ali-Sabieh'),
    const OunitModel(3, 'Tadjourah'),
    const OunitModel(68, 'Obock'),
    const OunitModel(67, 'Dikhil')
  ];
  List<SupplyModel> _supplyLists = <SupplyModel>[
    const SupplyModel(2495, 'SITE REGROUPEMENT GUELILEH')
  ];

  @override
  void dispose() {
    super.dispose();
  }

  _load() async {
    //var url = 'http://$APP_URL/api/list2/${_program.text}/${_project.text}/${_phase.text}/${_district.text}';

    var url = 'https://spmis.dcg-globalsolution.com/api/list2/' +
        _selectedProgram.id.toString() +
        '/' +
        _selectedProject.id.toString() +
        '/' +
        _selectedPhase.id.toString() +
        '/' +
        _selectedDistrict.id.toString() +
        '/4295';

    //_selectedSite.id.toString();

    print(url);

    var response = await http.get(Uri.parse(url));

    List<dynamic> listB = (convert.jsonDecode(response.body)[0] as List).map((dynamic e) => e as Map<String, dynamic>).toList();
    List<dynamic> listG = (convert.jsonDecode(response.body)[1] as List).map((dynamic e) => e as Map<String, dynamic>).toList();
    List<dynamic> listGrant = (convert.jsonDecode(response.body)[2] as List).map((dynamic e) => e as Map<String, dynamic>).toList();
    List<dynamic> listPA = (convert.jsonDecode(response.body)[3] as List).map((dynamic e) => e as Map<String, dynamic>).toList();

    Iterable<GroupementModel> gList =
    listG.map((model) => GroupementModel().fromJson(model));

    Iterable<BeneficiaryModel> bList =
    listB.map((model) => BeneficiaryModel().fromJson(model));

    Iterable<GrantModel> grantList =
    listGrant.map((model) => GrantModel().fromJson(model));

    Iterable<ProductiveActivityModel> paList =
    listPA.map((model) => ProductiveActivityModel().fromJson(model));

    bList.forEach((element) {
      DatabaseHelper.instance.insertBeneficiariesAndTransactions(element);
    });
    gList.forEach((element) {
      DatabaseHelper.instance.insertGroupementsAndActivities(element);
    });
    grantList.forEach((element) {
      DatabaseHelper.instance.insertGrants(element);
    });
    paList.forEach((element) {
      DatabaseHelper.instance.insertProductivesActivities(element);
    });

    setState(() {
      _isInAsyncCall = false;
      _isLoaded = true;
    });
    Flushbar(
      title: "Load Results",
      message: "Beneficiaries ${listB.length} was loaded \n Groupements ${listG.length} was loaded \n Subventions ${listGrant.length} was loaded \n Activites Productives ${listPA.length} was loaded",
      duration: Duration(seconds: 3),
    ).show(context);
  }

  _clean() async {
    DatabaseHelper.instance.clearAll('espmis_beneficiaries');
    DatabaseHelper.instance.clearAll('espmis_transactions');
    DatabaseHelper.instance.clearAll('espmis_groupements');
    DatabaseHelper.instance.clearAll('espmis_groupements_members');
    DatabaseHelper.instance.clearAll('espmis_grants');
    DatabaseHelper.instance.clearAll('espmis_productives_activities');
    DatabaseHelper.instance.clearAll('espmis_groupements_activities');
    DatabaseHelper.instance.clearAll('espmis_members_activities');
    Flushbar(
      title: "Clean Results",
      message: "All tables deleted ",
     duration: Duration(seconds: 3),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MainAppBar(
        context: context,
        leading: ButtonBackWhite(context),
        title: TitleAppBarWhite(title: S.of(context).title_loading),
      ),
      body: ModalProgressHUD(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 50),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        left: 30, right: 30, top: 30, bottom: 50),
                    child: Text(
                      S.of(context).lbl_loading_parameter.toUpperCase(),
                      style: TextStyle(
                          color: R.color.gray,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    //margin: EdgeInsets.only(top: 30, bottom: 30),
                  ),
                  //Divider(height: 1, thickness: 1),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<ProgramModel>(
                      isExpanded: true,
                      value: _selectedProgram,
                      items: _programLists.map((ProgramModel _program) {
                        return DropdownMenuItem<ProgramModel>(
                          value: _program,
                          child: Text(
                            _program.code,
                            style:
                                TextStyle(color: R.color.black, fontSize: 14),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedProgram = newValue;
                        });
                      },
                    ),
                  ),
                  Divider(height: 1, thickness: 1),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<ProjectModel>(
                      isExpanded: true,
                      value: _selectedProject,
                      items: _projectLists.map((ProjectModel _project) {
                        return DropdownMenuItem<ProjectModel>(
                          value: _project,
                          child: Text(
                            _project.code,
                            style:
                                TextStyle(color: R.color.black, fontSize: 14),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedProject = newValue;
                        });
                      },
                    ),
                  ),
                  Divider(height: 1, thickness: 1),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<PhaseModel>(
                      isExpanded: true,
                      value: _selectedPhase,
                      items: _phaseLists.map((PhaseModel _phase) {
                        return DropdownMenuItem<PhaseModel>(
                          value: _phase,
                          child: Text(
                            _phase.code,
                            style:
                                TextStyle(color: R.color.black, fontSize: 14),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedPhase = newValue;
                        });
                      },
                    ),
                  ),
                  Divider(height: 1, thickness: 1),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<OunitModel>(
                      isExpanded: true,
                      value: _selectedDistrict,
                      items: _ounitLists.map((OunitModel _ounit) {
                        return DropdownMenuItem<OunitModel>(
                          value: _ounit,
                          child: Text(
                            _ounit.code,
                            style:
                                TextStyle(color: R.color.black, fontSize: 14),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedDistrict = newValue;
                        });
                      },
                    ),
                  ),
                  Divider(height: 1, thickness: 1),
                  Container(
                    margin: EdgeInsets.all(20),
                  ),
                  /*DropdownButtonHideUnderline(
                    child: DropdownButton<SupplyModel>(
                      isExpanded: true,
                      value: _selectedSite,
                      items: _supplyLists.map((SupplyModel _supply) {
                        return DropdownMenuItem<SupplyModel>(
                          value: _supply,
                          child: Text(
                            _supply.code,
                            style:
                                TextStyle(color: R.color.black, fontSize: 14),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedSite = newValue;
                        });
                      },
                    ),
                  ),*/

                  Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          button(
                              width: 40,
                              text: S.of(context).btn_load_data.toUpperCase(),
                              onPressed: () {
                                setState(() {
                                  _isInAsyncCall = true;
                                });
                                if (!_isLoaded) _load();
                              }),
                          button(
                              width: 40,
                              text: S.of(context).btn_clean_data.toUpperCase(),
                              onPressed: () {
                                _clean();
                                setState(() {
                                  _isLoaded = false;
                                });
                              }),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
        inAsyncCall: _isInAsyncCall,
        // demo of some additional parameters
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(),
      ),
    );
  }

  Widget _ItemMessage(
          {BuildContext context,
          String title,
          String time,
          Function onPressed}) =>
      Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Card(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomCircleAvatar(
                    size: 30,
                    child: Image.asset(
                      R.image.avatar,
                      fit: BoxFit.fill,
                    )),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        maxLines: 5,
                        style: TextStyle(color: R.color.black, fontSize: 18),
                      ),
                      Text(
                        time,
                        style: TextStyle(color: R.color.gray, fontSize: 14),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: SizedBox(
                          width: 100,
                          height: 30,
                          child: button(
                              text: S.of(context).btn_reply.toUpperCase(),
                              width: 50,
                              height: 5,
                              onPressed: onPressed),
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      );
}
