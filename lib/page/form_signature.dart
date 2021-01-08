
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sambatin/utils/global_variable.dart';
import 'package:signature/signature.dart';

class FormSignaturePage extends StatefulWidget {
  @override
  _FormSignaturePageState createState() => _FormSignaturePageState();
}

class _FormSignaturePageState extends State<FormSignaturePage>  {

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

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
                            ],),
                        ),
                      ),
                      Expanded(
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(width: 1.0, color: Colors.lightBlueAccent)
                                ),
                                child: Signature(
                                  controller: _controller,
                                  height: MediaQuery.of(context).size.height,
//                            height: 300,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              Align(alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Hapus'),
                                    ),
                                    onTap: () => _controller.clear(),
                                  )
                              ),
                            ],),)
                    ],),
                )
            )
        )
    );
  }
}