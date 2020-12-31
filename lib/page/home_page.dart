import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'akun/akun_page.dart';
import 'dashboard/dashboard_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedIndex;


  @override
  void initState() {
    selectedIndex = 0;
    super.initState();
  }

  List<Widget> _buildScreens = [
    DashboardPage(),
    AkunPage()
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightBlue,
        child: SafeArea(
            child: Scaffold(
                key: _scaffoldKey,
                bottomNavigationBar: FFNavigationBar(
                    theme: FFNavigationBarTheme(
                      barBackgroundColor: Colors.white,
                      selectedItemBorderColor: Colors.white,
                      selectedItemBackgroundColor: Colors.lightBlue,
                      selectedItemIconColor: Colors.white,
                      selectedItemLabelColor: Colors.lightBlue,
                      showSelectedItemShadow: true,
                    ),
                    selectedIndex: selectedIndex,
                    onSelectTab: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    items: _listFF()
                ),

                body: _buildScreens[selectedIndex]
            )));
  }

  List<FFNavigationBarItem> _listFF(){
    return [
      FFNavigationBarItem(
        iconData: Icons.home,
        label: 'Home',
      ),
      FFNavigationBarItem(
        iconData: Icons.account_circle,
        label: 'Akun',
      )
    ];
  }
}