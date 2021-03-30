import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login_screen/Utils/Validations.dart';
import 'package:flutter_login_screen/screen/signup_screen.dart';
import 'package:flutter_login_screen/widgets/text-form-input-custom.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  Map userDataLogin = new HashMap<String, dynamic>();
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();

  _readSpLoginData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userKey = "email_key";
    final String passwordKey = "password_key";
    final String userName = prefs.getString(userKey);
    final String password = prefs.getString(passwordKey);
    userDataLogin  = {
      'login': userName,
      'password': password
    };
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child:
                SizedBox(
                    height: 180.0,
                    child: Image.asset("assets/logo.jpg")),
          ),

          SizedBox(height: 25.0),

          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              "Login",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700
              ),
            ),
          ),

          SizedBox(height: 10.0),

          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              "Faça o login para continuar",
              style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 17.0
              ),
            ),
          ),

          Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 30.0),

                TextFormInputCustom(icon: Icons.email, placeholder: "Email",
                                    validation: Validations.isValidEmail,
                                    inputType: TextInputType.emailAddress,
                                    controller: _emailController),

                SizedBox(height: 20.0),

                TextFormInputCustom(icon: Icons.lock_sharp, placeholder: "Senha",
                                    validation: Validations.isEmpty,
                                    inputType: TextInputType.visiblePassword,
                                    isPassword: true,
                                    controller: _passwordController),

                SizedBox(height: 20.0),

                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  width: 250.0,
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(255, 1, 191, 165)),
                      color: Color.fromARGB(255, 1, 191, 165),
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),

                  child: TextButton(

                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          // Load user information from sharedPreferences
                          await _readSpLoginData();

                          // Valid user
                          if(_emailController.text == userDataLogin['login']
                              && _passwordController.text == userDataLogin['password']) {

                            return Alert(
                              context: context,
                              style: AlertStyle(
                                backgroundColor: Theme.of(context).primaryColor,
                                descStyle: TextStyle(color: Colors.white, fontSize: 15),
                                titleStyle: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              type: AlertType.success,
                              title: "SUCESSO",
                              desc: "LOGIN REALIZADO",

                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "OK",
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  width: 120,
                                  color: Color.fromARGB(255, 1, 191, 165),
                                )
                              ],
                            ).show();

                          }

                          else {
                            return Alert(
                              context: context,
                              style: AlertStyle(
                                backgroundColor: Theme.of(context).primaryColor,
                                descStyle: TextStyle(color: Colors.white, fontSize: 15),
                                titleStyle: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              type: AlertType.error,
                              title: " ",
                              desc: "Usuario não emcotrado para os dados informados",

                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "OK",
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  width: 120,
                                  color: Color.fromARGB(255, 1, 191, 165),
                                )
                              ],
                            ).show();
                          }
                        }
                      },
                      child: Text("LOGIN",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)
                        )
                  ),
                ),
              ],
            )
          ),

          SizedBox(height: 12.0),

          Container(
            margin: const EdgeInsets.only(top: 70.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Não tem uma conta?",
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 17.0
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(context, PageTransition(
                        curve: Curves.linear,
                        type: PageTransitionType.bottomToTop,
                        child: SignUpScreen() )
                    );
                  },
                  child: Center(
                      child: Text(
                          "  Cadastre-se",
                          style: TextStyle(
                              color: Color.fromARGB(255, 1, 191, 165),
                              fontSize: 17.0)
                      )
                  ),
                ),

              ],
            ),
          ),

    ],
      ),

    );
  }
}
