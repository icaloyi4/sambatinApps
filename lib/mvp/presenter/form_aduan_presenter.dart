
import 'dart:ui';

import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sambatin/mvp/model/form_aduan_model.dart';
import 'package:sambatin/mvp/view/view.dart';
import 'package:sambatin/utils/api/api_const.dart';
import 'package:sambatin/utils/api/api_helper.dart';
import 'package:sambatin/utils/api/response_model/BaseResponse.dart';
import 'package:sambatin/utils/api/response_model/get_responder_responder.dart';
import 'package:sambatin/utils/global_variable.dart';
import 'package:sambatin/utils/global_widget.dart';
import 'package:sambatin/utils/setting_servicer.dart';

class FormAduanPresenter {
  set view(FormAduanView v) {}
  Future<void> initServices() async {}
  Future<void> getResponder() async {}
  Future<void> addContent(String content) async {}
}

class BasicFormAduanPresenter implements FormAduanPresenter {
  FormAduanView v;
  FormAduanModel m;
  ApiBaseHelper _helper;
  SettingService settingService;
  ArsProgressDialog progressDialog;

  BasicFormAduanPresenter() {
    m = FormAduanModel();
    progressDialog = ArsProgressDialog(
        m.context,
        blur: 2,
        backgroundColor: Color(0x33000000),
        animationDuration: Duration(milliseconds: 500));
    _helper = ApiBaseHelper();
  }

  @override
  Future<void> initServices() async {
    settingService = await SettingService.getService();
    getResponder();
  }

  @override
  set view(FormAduanView v) {
    this.v = v;
    v.refreshView(m);
  }

  @override
  Future<void> getResponder() async {
    try {
      final responder = await _helper.post(
          MyApiConst.searchfollowinguser,
          {},
          {
            'id_user' : userData.data[0].id.toString(),
          }
      );
      final kontenData = GetResponderResponse.fromJson(responder);
      if(kontenData.data.isNotEmpty){
        m.listResponder.addAll(kontenData.data);
      } else {
        showSnackbar(m.scaffoldKey, 'Tidak ada aduan');
      }
    } catch (e) {
      print(e);
      showSnackbar(m.scaffoldKey, 'Error $e');
    } finally {
      v.refreshView(m);
    }
  }

  @override
  Future<void> addContent(String content) async {
//    progressDialog.show();
    try {
    final userResponse = await _helper.post(
        MyApiConst.insertContent,
        {},
        {
          'signature' : m.signature,
          'gambar' : m.fotBase64,
          'content' : content,
          'id_user' : userData.data[0].id.toString(),
          'id_responder' : m.selectedResponder.id.toString()
        }
    );
      var response = BaseResponse.fromJson(userResponse);
      if(response.code==200){
        Navigator.pop(m.context);
      } else {
        showSnackbar(m.scaffoldKey, 'Email atau password salah');
      }
    } catch (e) {
      print(e);
      showSnackbar(m.scaffoldKey, 'Error $e');
    } finally {
//      progressDialog.dismiss();
    }
  }
}