import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sambatin/utils/global_conts.dart';
import 'package:sambatin/utils/global_variable.dart';
import 'package:sambatin/utils/route.dart';
import 'package:sambatin/utils/setting_servicer.dart';

class AkunPage extends StatefulWidget {
  @override
  _AkunPageState createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  SettingService settingService;
  var isLogin = false;
  @override
  void initState() {
    initService();
    /*if (userData.user != null) {
      isLogin = true;
    }*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightBlue,
        child: SafeArea(
            child: Scaffold(
                key: _scaffoldKey,
                body: Center(child: GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app, color: Colors.red),
                        SizedBox(width: 10),
                        Expanded(
                            child: Text(
                              'Logout',
                              style: TextStyle(fontSize: 20, color: Colors.red),
                            ))
                      ],
                    ),
                  ),
                  onTap: () async {
                    await logout();
                  },
                ),)
            )
        )
    );
  }

  Future logout() async {
    await settingService.del(MyConst.USER);
    userData = null;
    Navigator.of(context)
        .pushReplacementNamed(NavigateName.login);
  }

  Future initService() async {
    settingService = await SettingService.getService();
  }
}
