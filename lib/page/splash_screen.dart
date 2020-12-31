import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sambatin/utils/api/response_model/sign_in_response.dart';
import 'package:sambatin/utils/global_conts.dart';
import 'package:sambatin/utils/global_variable.dart';
import 'package:sambatin/utils/my_images.dart';
import 'package:sambatin/utils/route.dart';
import 'package:sambatin/utils/setting_servicer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SettingService settingService;
  navigateDelay(String page) async {
    var _duration = new Duration(milliseconds: 3000);
    return new Timer(_duration, () {
      switch (page) {
        case NavigateName.login:
          return Navigator.of(context).pushReplacementNamed(page);
        case NavigateName.home:
          return Navigator.of(context).pushReplacementNamed(page);
        default:
          throw 'Route $page is not defined';
      }

    });
  }

  @override
  void initState() {
    cekUser();
    // Navigator.of(context).pushReplacementNamed(NavigateName.landingPage1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueGrey,
      body: Container(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
            ),
            Center(
              child: Image(
                  image: AssetImage(MyImages.mainLogoWhite),
                  width: MediaQuery.of(context).size.width * 60 / 100),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> cekUser() async {
    log('[ Cek User ]');
    try {
      settingService = await SettingService.getService();
      var data = await settingService.get(MyConst.USER);
      if(data!=null){
        userData = UserResponse.fromJson(jsonDecode(data));
        navigateDelay(NavigateName.home);
      } else {
        navigateDelay(NavigateName.login);
      }
    } catch (err) {
      print(err);
//      error(err.toString());
    }
  }

}
