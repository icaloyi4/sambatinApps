import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sambatin/utils/global_variable.dart';

class FormAduanPage extends StatefulWidget {
  @override
  _FormAduanPageState createState() => _FormAduanPageState();
}

class _FormAduanPageState extends State<FormAduanPage> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightBlue,
        child: SafeArea(
          child: Scaffold(
  //        key: m.scaffoldKey,
          backgroundColor: Colors.white,
            body: Container(
              child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left:8.0, right: 8.0, top: 10.0, bottom: 10.0),
                      child: Row(
                        children: [
                          Icon(Icons.clear_outlined, color: Colors.lightBlueAccent,),
                          Expanded(child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.account_circle),
                                SizedBox(width: 5,),
                                Text(userData.data[0].nama)
                              ],
                            ),
                          )),
                          Icon(Icons.search, color: Colors.lightBlueAccent,)
                        ],),
                    ),
                  ),
                ],),
            )
          )
        )
    );
  }
}