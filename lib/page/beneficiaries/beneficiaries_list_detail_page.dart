import 'package:mspmis/model/beneficiary_model.dart';
import 'package:flutter/material.dart';

class BeneficiaryDetails extends StatelessWidget {
  const BeneficiaryDetails({Key key, @required this.data})
      : assert(data != null),
        super(key: key);

  final BeneficiaryModel data;

  Iterable<MapEntry<String, String>> get _fieldValues =>
      _onGenerateFields(data).entries;

  @override
  Widget build(BuildContext context) {
    //

    final _width = ScreenQueries.instance.width(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CloseButton(),
        for (final _fieldValue in _fieldValues) ...[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: _width * 0.2,
                  child: Text(_fieldValue.key),
                ),
                SizedBox(
                  width: _width * 0.2,
                  child: Text(
                    _fieldValue.value,
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              ],
            ),
          ),
        ],
      ],
    );
  }

  Map<String, String> _onGenerateFields(BeneficiaryModel _data) {
    final _fieldValues = {
      'ID Beneficiaire : ': _data.id.toString(),
      'ID Individu : ': _data.individual_id.toString(),
      'ID Programme : ': _data.program_id.toString(),
      'ID Projet : ': _data.project_id.toString(),
      'ID Phase : ': _data.phase_id.toString(),
      'Chef Menage : ': "",
      'Conjointe : ': "",
      'District : ': _data.district,
      'Commune/(Ss) Prefecture :': _data.county,
      'Localite/Arrondissement :': _data.constituency,
      'Quartier : ': _data.ward
    };

    return _fieldValues;
  }
}

class ScreenQueries {
  ScreenQueries._privateConstructor();

  static final instance = ScreenQueries._privateConstructor();

  /// Get the width...
  double width(BuildContext context) => MediaQuery.of(context).size.width;

  /// Get the height...
  double height(BuildContext context) => MediaQuery.of(context).size.height;

  /// Custom width...
  double customWidth(BuildContext context, double divideBy) =>
      (MediaQuery.of(context).size.width / divideBy).truncateToDouble();

  /// Custom height...
  double customHeight(BuildContext context, double divideBy) =>
      (MediaQuery.of(context).size.height / divideBy).truncateToDouble();

  /// Custom width in percent...
  double customWidthPercent(BuildContext context, double percent) =>
      (MediaQuery.of(context).size.width * percent).truncateToDouble();

  /// Custom height in percent...
  double customHeightPercent(BuildContext context, double percent) =>
      (MediaQuery.of(context).size.height * percent).truncateToDouble();
}
