import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:sambatin/mvp/model/sign_in_model.dart';
import 'package:sambatin/mvp/view/view.dart';
import 'package:sambatin/utils/api/api_const.dart';
import 'package:sambatin/utils/api/api_helper.dart';
import 'package:sambatin/utils/api/response_model/sign_in_response.dart';
import 'package:sambatin/utils/global_conts.dart';
import 'package:sambatin/utils/global_variable.dart';
import 'package:sambatin/utils/global_widget.dart';
import 'package:sambatin/utils/route.dart';
import 'package:sambatin/utils/setting_servicer.dart';

class SignInPresenter {
  set view(SignInView v) {}
  Future<void> login() async {}
  Future<void> initServices() async {}
}

class BasicSignInPresenter implements SignInPresenter {
  SignInView v;
  SignInModel m;
  ApiBaseHelper _helper;
  SettingService settingService;

  BasicSignInPresenter() {
    m = SignInModel();
    _helper = ApiBaseHelper();

  }

  @override
  Future<void> initServices() async {
    settingService = await SettingService.getService();
  }

  @override
  set view(SignInView v) {
    this.v = v;
    v.refreshView(m);
  }

  @override
  Future<void> login() async  {
    m.isLogin = true;
    v.refreshView(m);
    if(m.loginKey.currentState.validate()) {
      m.loginKey.currentState.save();

      final userResponse = await _helper.post(
          MyApiConst.login,
          {},
          {
            'email' : m.email,
            'password' : m.password,
          }
      );

      try {
        userData = UserResponse.fromJson(userResponse);
        if(userData.data.isNotEmpty){
          await settingService.set(MyConst.USER, json.encode(userData));
          showSnackbar(m.scaffoldKey, 'Masuk');
          Navigator.of(m.context).pushReplacementNamed(NavigateName.home);
        } else {
          showSnackbar(m.scaffoldKey, 'Email atau password salah');
        }
      } catch (e) {
        print(e);
        showSnackbar(m.scaffoldKey, 'Error $e');
      } finally {
        m.isLogin = false;
        v.refreshView(m);
      }
    } else {
      m.isLogin = false;
      v.refreshView(m);
    }
  }
}
