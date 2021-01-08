import 'dart:convert';
import 'dart:io';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sambatin/mvp/model/form_aduan_model.dart';
import 'package:sambatin/mvp/presenter/form_aduan_presenter.dart';
import 'package:sambatin/mvp/view/view.dart';
import 'package:sambatin/utils/api/response_model/get_responder_responder.dart';
import 'package:sambatin/utils/global_variable.dart';
import 'package:sambatin/utils/route.dart';
import 'package:signature/signature.dart';

class FormAduanPage extends StatefulWidget {
  @override
  _FormAduanPageState createState() => _FormAduanPageState(new BasicFormAduanPresenter());
}

class _FormAduanPageState extends State<FormAduanPage> implements FormAduanView {
  final BasicFormAduanPresenter p;
  _FormAduanPageState(this.p);

  FormAduanModel m;
  TextEditingController searchController = new TextEditingController();
  TextEditingController contentController = new TextEditingController();
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void initState() {
    this.p.view = this;
    this.p.initServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    m.context = context;
//    FocusScope.of(context).unfocus();
    return Container(
        color: Colors.lightBlue,
        child: SafeArea(
          child: Scaffold(
          key: m.scaffoldKey,
          backgroundColor: Colors.white,
            body: GestureDetector(
              onHorizontalDragDown: (details) => FocusScope.of(context).unfocus() ,
//              onTap: () => FocusScope.of(context).unfocus(),
              child: Container(
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
                            btnPosting()
                          ],),
                      ),
                    ),
                    Expanded(
                        child: SingleChildScrollView(child: formAduan(),))
                  ],),
              ),
            )
          )
        )
    );
  }

  Widget formAduan() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Form(
//        key: m.loginKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: m.listResponder.isEmpty
                    ? CircularProgressIndicator()
                    : AutoCompleteTextField<Data>(
                  textInputAction: TextInputAction.next,
                  decoration: new InputDecoration(
                      hintText:
                      "Adukan kepada ...",
                      suffixIcon:
                      new Icon(Icons.search)),
                  itemSubmitted: (item) =>
                      setState(() {
                        m.selectedResponder = item;
                        searchController.text =
                            item.nama;
                      }),
                  key: m.keyResponder,
                  suggestions: m.listResponder,
                  controller: searchController,
                  clearOnSubmit: false,
                  itemBuilder: (acontext,
                      suggestion) =>
                  new Padding(
                      child: new ListTile(
                        title: new Text(
                            suggestion.nama),
                      ),
                      padding:
                      EdgeInsets.all(8.0)),
                  itemFilter: (suggestion, input) =>
                      suggestion.nama
                          .toLowerCase()
                          .startsWith(
                          input.toLowerCase()),
                  itemSorter: (a, b) {
                    return a.nama.compareTo(b.nama);
                  },
                )),
              ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: TextFormField(
                    keyboardType: TextInputType.multiline,
                  minLines: 1,//Normal textInputField will be displayed
                  maxLines: 10,
                  controller: contentController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.lightBlue),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    labelText: 'Aduan',
                    hintText: 'Tulis Aduan Disini ...',
                  ),
                  autofocus: true,
                  // ignore: missing_return
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Pilih tujuan aduan';
                    }
                  },
//                  onSaved: (value) => {m.email = value},
                ),
              ),
            ),
            Row(
                  children: [
                    m.foto==null
                        ?Container():Expanded(
                      child: Stack(
                        children: [
                      Card(
                          elevation: 4,
                          child: ClipRRect(borderRadius: BorderRadius.circular(8.0),child: Image.file(m.foto, width: MediaQuery.of(context).size.width, fit: BoxFit.fitHeight,))),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.red),
                                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)]),
                                child: Icon(Icons.clear_rounded, color: Colors.red,)
                            ),
                            onTap: () {
                              setState(() {
                                m.foto = null;
                              });
                            },
                          ),
                        ),
                      )
              ],),
                    ),
                    SizedBox(width: 10,),
                    Expanded(child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Tanda Tangan', ),
                      SizedBox(height: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border(
                                    bottom: BorderSide(
                                      color: Colors.lightBlueAccent,
                                    ))
                            ),
                            child: Column(
                              children: [
                                Text('Saya menyatakan informasi yang saya berikan benar adanya.', style: TextStyle(fontSize: 8),),
                                Signature(
                                  height: 150,
                                  width: 200,
                                  controller: _controller,
//                            height: 300,
                                  backgroundColor: Colors.white,
                                ),
                                Text(userData.data[0].nama)
                              ],
                            ),
                          ),
                          Align(alignment: Alignment.center,
                              child: GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Hapus'),
                                ),
                                onTap: () => _controller.clear(),
                              )
                          ),
                        ],),],))
                  ],
                ),
            SizedBox(height: 10,),
            m.foto==null
                ?btnAddPhoto()
                :Container()
          ],),
      ),
    );
  }

  Widget btnPosting() {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.lightBlue)
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Align(alignment: Alignment.center,child: Text('Posting', style: TextStyle(color: Colors.white),)),
        ),
      ),
      onTap: () async {
        if(_controller.isNotEmpty && m.selectedResponder!=null && contentController.text.isNotEmpty){
          final bytes = await _controller.toPngBytes();
          m.signature = base64Encode(bytes);
          p.addContent(contentController.text);
        }

      },
    );
  }

  Widget btnAddPhoto() {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.lightBlue)
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Align(alignment: Alignment.center,child: Icon(Icons.camera_alt, color: Colors.white,)),
        ),
      ),
      onTap: () => _showPicker(m.context),
    );
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );
    setState(() {
      m.foto = image;
      m.fotBase64 = base64Encode(image.readAsBytesSync());
    });
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      m.foto = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  @override
  void refreshView(FormAduanModel model) {
    setState(() {
      this.m = model;
    });
  }
}