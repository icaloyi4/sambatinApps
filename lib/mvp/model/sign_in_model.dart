import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInModel {
  var loginKey = new GlobalKey<FormState>();
  var scaffoldKey = new GlobalKey<ScaffoldState>();

  var isLogin = false;

  var email = '';
  var password = '';
  BuildContext context;
}