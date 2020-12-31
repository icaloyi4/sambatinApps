import 'package:flutter/material.dart';
import 'package:sambatin/utils/api/response_model/user_content_response.dart';

class DashboardModel{
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  BuildContext context;
  var isAmbilKonten = false;
  List<Data> konten = [];

}