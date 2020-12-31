
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sambatin/mvp/model/dashboard_model.dart';
import 'package:sambatin/mvp/presenter/dashboard_presenter.dart';
import 'package:sambatin/mvp/view/view.dart';
import 'package:sambatin/utils/global_widget.dart';
import 'package:sambatin/utils/my_images.dart';
import 'package:sambatin/utils/route.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState(new BasicDashboardPresenter());
}

class _DashboardPageState extends State<DashboardPage> implements DashboardView {

  final BasicDashboardPresenter p;
  _DashboardPageState(this.p);

  DashboardModel m;

  @override
  void initState() {
    this.p.view = this;
    this.p.initServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    m.context = context;
    return Container(
        color: Colors.lightBlue,
        child: SafeArea(
            child: Scaffold(
                key: m.scaffoldKey,
                backgroundColor: Colors.white,
                body: Container(
                  child: Column(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left:8.0, right: 8.0),
                          child: Row(
                            children: [
                              Container(height:50,child: Image.asset(MyImages.bannerLogoWhite)),
                              Expanded(child: Container()),
                              Icon(Icons.search, color: Colors.lightBlueAccent,)
                            ],),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            m.isAmbilKonten?Center(child: CircularProgressIndicator()):itemListProgram(),
                            GestureDetector(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.lightBlue),
                                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)]),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.campaign, color: Colors.lightBlue,),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () => Navigator.pushNamed(m.context, NavigateName.form_aduan),
                            ),
                          ],)
                      )
                    ],
                  ),
                )
            )));
  }

  Widget itemListProgram() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    padding: EdgeInsets.all(0),
    itemCount: m.konten.length,
    itemBuilder: (context, i) {
          return Card(
            elevation: 4,
            child: Container(
              color: Colors.white,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:10.0, right: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.account_circle, size: 40, color: Colors.lightBlue,),
                            SizedBox(width: 10,),
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(m.konten[i].namaUser+" ke "+m.konten[i].namaResponden, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                Text(m.konten[i].createAt, style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),),
                                SizedBox(height: 10,),
                                Text(m.konten[i].content,style: TextStyle(fontSize: 16),),
                                SizedBox(height: 5,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.question_answer, color: Colors.lightBlueAccent,),
                                        SizedBox(width: 5,),
                                        Text(m.konten[i].jmlComment.toString())
                                      ],
                                    ),
                                    Expanded(child: Align(
                                      alignment: Alignment.bottomRight,
                                        child: m.konten[i].aktif==1?Text('Aduan Terbuka', style: TextStyle(color: Colors.lightBlueAccent),):Text('Aduan Ditutup', style: TextStyle(color: Colors.black26),)))
                                  ],)
                              ],
                            ))
                          ],),
                      ),
                      /*line(MediaQuery.of(context).size.width, 1.0, Colors.lightBlueAccent),*/

                    ],
                  )
              ),
            ),
          );
    }
    );
    }

  @override
  void refreshView(DashboardModel model) {
    setState(() {
      this.m = model;
    });
  }
}
