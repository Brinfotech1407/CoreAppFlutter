import 'package:mspmis/model/beneficiary_model.dart';
import 'package:mspmis/model/grievance_categories_model.dart';
import 'package:mspmis/model/grievance_types_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_input/flutter_input.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/generated/i18n.dart';
import 'package:mspmis/utils/utils.dart';

import 'package:mspmis/helpers/DatabaseHelper.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddGrievancePage extends StatefulWidget {
  AddGrievancePage({Key key, this.beneficiary}) : super(key: key);
  final BeneficiaryModel beneficiary;

  @override
  _AddGrievancePageState createState() {
    return _AddGrievancePageState();
  }
}

class _AddGrievancePageState extends State<AddGrievancePage> {
  bool isSearching = false;
  FocusNode _focusSearch = FocusNode();
  final _formKey = GlobalKey<FormState>();

  GrievanceTypeModel _selectedGrievanceType;
  GrievanceCategoryModel _selectedGrievanceCategory;
  String description = "";
  String grievance_date = "";
  final descriptionGrievanceController = TextEditingController();

  GrievanceModel g = GrievanceModel();
  List<GrievanceModel> grievances = [];

  Future<List<GrievanceModel>> _grievances;

  bool isUpdate = false;
  int grievanceIdForUpdate;
  // Guichet Social Arta 2204
  // Guichet Social Tadjourah 2203
  //Guichet Social Ali Sabieh 2200
  //Guichet Social Obock 2202
  //Guichet Social Dikhil

  List<GrievanceTypeModel> _grievanceTypeLists = <GrievanceTypeModel>[
    const GrievanceTypeModel(4, 'Transferts Monetaires'),
    const GrievanceTypeModel(2, 'Perte Document PNSF'),
    const GrievanceTypeModel(16, 'Orientation')
  ];
  List<GrievanceCategoryModel> _grievanceCategoryLists =
      <GrievanceCategoryModel>[
    const GrievanceCategoryModel(9, 'Transfert Non Recu'),
    const GrievanceCategoryModel(7, 'Transfert Suspendu'),
    const GrievanceCategoryModel(5, 'Perte Livret PNSF'),
    const GrievanceCategoryModel(8, 'Changement Site TM')
  ];

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    setState(() {
      isUpdate = false;
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
              : TitleAppBarWhite(title: S.of(context).title_add_grievances),
          actions: isSearching
              ? []
              : [
                  /*
                  IconButton(
                      icon: SvgPicture.asset(R.image.ic_search),
                      onPressed: () {
                        setState(() {
                          isSearching = true;
                        });
                      })*/
                ]),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(0),
            child: Form(
              autovalidateMode: AutovalidateMode.always, key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                    child: TextFormField(
                      controller: descriptionGrievanceController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText:
                              S.of(context).hint_input_grievance_description),
                      onChanged: (newValue) {
                        setState(() {
                          g.description = newValue;
                          description = newValue;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                    child: InputDropdown<GrievanceTypeModel>(
                        isExpanded: true,
                        value: _selectedGrievanceType,
                        decoration: InputDecoration(
                          labelText: S.of(context).hint_input_grievance_type,
                          hintText: '<Please select one item',
                        ),
                        items:
                            _grievanceTypeLists.map((GrievanceTypeModel _type) {
                          return DropdownMenuItem<GrievanceTypeModel>(
                            value: _type,
                            child: Text(
                              _type.code,
                              style:
                                  TextStyle(color: R.color.black, fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            g.grievance_types_id = newValue.id;
                            _selectedGrievanceType = newValue;
                          });
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                    child: InputDropdown<GrievanceCategoryModel>(
                      isExpanded: true,
                      value: _selectedGrievanceCategory,
                      decoration: InputDecoration(
                          labelText:
                              S.of(context).hint_input_grievance_category,
                          hintText: '<Please select one item>'),
                      items: _grievanceCategoryLists
                          .map((GrievanceCategoryModel _type) {
                        return DropdownMenuItem<GrievanceCategoryModel>(
                          value: _type,
                          child: Text(
                            _type.code,
                            style:
                                TextStyle(color: R.color.black, fontSize: 14),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          g.grievance_categories_id = newValue.id;
                          _selectedGrievanceCategory = newValue;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                    child: InputWidget(
                        hint: S.of(context).hint_date,
                        bottom: 20,
                        text: grievance_date,
                        onTap: () {
                          final date = DateTime.now();
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime(1970, 1, 1),
                            maxTime: DateTime(date.year, date.month, date.day),
                            onChanged: (date) {
                              print('change $date');
                              g.grievance_date = date.toIso8601String();
                              grievance_date = date.toIso8601String();
                            },
                            onConfirm: (date) {
                              print('confirm $date');
                              g.grievance_date = date.toIso8601String();
                              grievance_date = date.year.toString() +
                                  "-" +
                                  date.month.toString() +
                                  "-" +
                                  date.day.toString();
                            },
                            currentTime: DateTime.now(),
                          );
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      button(
                          width: 40,
                          text: isUpdate
                              ? S.of(context).btn_update_grievance.toUpperCase()
                              : S.of(context).btn_save_grievance.toUpperCase(),
                          onPressed: () {
                            if (isUpdate) {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                DatabaseHelper.instance
                                    .updateGrievance(g)
                                    .then((data) {
                                  setState(() {
                                    isUpdate = false;
                                  });
                                });
                              }
                            } else {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                g.beneficiary_id = widget.beneficiary.id;
                                DatabaseHelper.instance.insertGrievance(g);
                              }
                            }
                            descriptionGrievanceController.text = '';
                            _init();
                          }),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      button(
                          width: 40,
                          text: isUpdate
                              ? S.of(context).btn_delete_grievance.toUpperCase()
                              : S
                                  .of(context)
                                  .btn_cancel_grievance
                                  .toUpperCase(),
                          onPressed: () {
                            descriptionGrievanceController.text = '';

                            setState(() {
                              isUpdate = false;
                              _selectedGrievanceCategory = null;
                              _selectedGrievanceType = null;
                              grievance_date = "";
                              grievanceIdForUpdate = null;
                            });
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
