import 'package:flutter/material.dart';

class GrievanceHistoryDetails extends StatelessWidget {
  const GrievanceHistoryDetails({Key key, @required this.data})
      : assert(data != null),
        super(key: key);

  final Map<String, dynamic> data;

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

  Map<String, String> _onGenerateFields(Map<String, dynamic> _data) {
    print(data['name']);
    final _fieldValues = {
      'ID : ': _data['id'].toString(),
      'Recipiendaire : ': _data['name'].toString(),
      'Beneficiaire ID : ': _data['beneficiary_id'].toString(),
      'Categorie ID : ': _data['grievance_types_id'].toString(),
      'Sous Categorie ID : ': _data['grievance_categories_id'].toString(),
      'Status: ': _data['grievance_flag'].toString(),
      'Description : ': _data['description'].toString(),
      'Date Plainte/Doleance : ': _data['grievance_date'] == null
          ? ""
          : _data['grievance_date'].toString(),
      'Date Sync : ': _data['grievance_sync_date'] == null
          ? ""
          : _data['grievance_sync_date'].toString()
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
