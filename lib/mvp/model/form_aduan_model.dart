import 'dart:io';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:sambatin/mvp/model/base_model.dart';
import 'package:sambatin/utils/api/response_model/get_responder_responder.dart';

class FormAduanModel extends BaseModel{
  File foto;
  var keyResponder = new GlobalKey<AutoCompleteTextFieldState<Data>>();
  List<Data> listResponder = [];

  Data selectedResponder;
}