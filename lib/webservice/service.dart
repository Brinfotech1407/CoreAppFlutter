import 'dart:convert';
import 'package:mspmis/helpers/databaseHelper.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mspmis/model/beneficiary_model.dart';

class Resource<T> {
  final String url;
  T Function(Response response) parse;

  Resource({this.url,this.parse});
}

class Webservice {


}