
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sambatin/mvp/model/sign_in_model.dart';
import 'package:sambatin/mvp/presenter/sign_in_presenter.dart';
import 'package:sambatin/mvp/view/view.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState(new BasicSignInPresenter());
}

class _LoginPageState extends State<LoginPage> implements SignInView {

  var _passwordVisible = false;
  final BasicSignInPresenter p;
  _LoginPageState(this.p);

  SignInModel m;

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
                body: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,)
            )
        )
    );
  }

  Widget formLogin() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Form(
        key: m.loginKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.lightBlue),
                    border: UnderlineInputBorder(
                        borderSide: new BorderSide(
                            color: Colors.lightBlue
                        )
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(
                            color: Colors.lightBlue
                        )
                    ),
                    labelText: 'Email',
                  ),
                  // ignore: missing_return
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter email';
                    }
                  },
                  onSaved: (value) => {m.email = value},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText:
                  !_passwordVisible, //This will obscure text dynamically
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.lightBlue),
                    labelText: 'Password',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(
                            color: Colors.lightBlue
                        )
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.lightBlue,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  // initialValue: 'admintest',
                  // initialValue: '123',
                  // ignore: missing_return
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter email';
                    }
                  },
                  onSaved: (value) => {m.password = value},
                ),
              ),
            ),
          ],),
      ),
    );
  }

  Widget btnLogin() {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.lightBlue)
        ),
        width: MediaQuery.of(context).size.width * 50/100,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Align(alignment: Alignment.center,child: Text('Login', style: TextStyle(color: Colors.lightBlue),)),
        ),
      ),
      onTap: () => p.login(),
    );
  }

  @override
  void refreshView(SignInModel model) {
    setState(() {
      this.m = model;
    });
  }

  Widget btnForgot() {
    return GestureDetector(
      child: Container(margin: EdgeInsets.all(10),child: Text('forgot password?',style: TextStyle(color: Colors.lightBlue, fontSize: 12),)),
    );
  }

  Widget btnRegister() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Tidak Punya Akun? ',style: TextStyle(color: Colors.lightBlue),),
          GestureDetector(
            child: Text('Daftar Disini', style: TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold),),
            /*onTap: () => Navigator.pushNamed(context, NavigateName.register, arguments: ''),*/
          )
        ],
      ),
    );
  }


}