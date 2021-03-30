import 'package:flutter/material.dart';
import 'package:flutter_login_screen/Utils/Validations.dart';
import 'package:flutter_login_screen/widgets/text-form-input-custom.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  final _nameController = new TextEditingController();
  final _phoneNumberController = new TextEditingController();
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();
  final _passwordConfirmController = new TextEditingController();

  _saveUserData (Map userData) async {
    final prefs = await SharedPreferences.getInstance();
    final nameKey = "name_key";
    final phoneKey = "phone_key";
    final emailKey = "email_key";
    final passwordKey = "password_key";

    prefs.setString(nameKey, userData['name']);
    prefs.setString(phoneKey, userData['number']);
    prefs.setString(emailKey, userData['email']);
    prefs.setString(passwordKey, userData['password']);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: [

            SizedBox(height: 35.0),

            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                "Criar Conta",
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
                "Por favor preencha os dados abaixo",
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
                    SizedBox(height: 50.0),

                    TextFormInputCustom(icon: Icons.person_outline,
                                        placeholder: "Nome Completo",
                                        validation: Validations.isEmpty,
                                         controller: _nameController,),

                    SizedBox(height: 20.0),

                    TextFormInputCustom(icon: Icons.phone_android,
                                        placeholder: "Phone",
                                        validation: Validations.isValidNumber,
                                        inputType: TextInputType.number,
                                        controller: _phoneNumberController),

                    SizedBox(height: 20.0),

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

                    TextFormInputCustom(icon: Icons.lock_sharp, placeholder: "Confirme a Senha",
                        validation: Validations.isEmpty,
                        inputType: TextInputType.visiblePassword,
                        isPassword: true,
                        controller: _passwordConfirmController),

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

                              if(_passwordController.text != _passwordConfirmController.text) {
                                return Alert(
                                  context: context,
                                  style: AlertStyle(
                                    backgroundColor: Theme.of(context).primaryColor,
                                    descStyle: TextStyle(color: Colors.white, fontSize: 15),
                                    titleStyle: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  type: AlertType.error,
                                  title: "SENHAS DIFERENTES",
                                  desc: "As senhas digitadas são diferentes, vefique novamente.",

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

                                Map userData = {
                                  'name': _nameController.text,
                                  'number': _phoneNumberController.text,
                                  'email': _emailController.text,
                                  'password': _passwordController.text
                                };
                                await _saveUserData(userData);

                                return Alert(
                                  context: context,
                                  style: AlertStyle(
                                    backgroundColor: Theme.of(context).primaryColor,
                                    descStyle: TextStyle(color: Colors.white, fontSize: 15),
                                    titleStyle: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  type: AlertType.success,
                                  title: " ",
                                  desc: "Usuario criado com sucesso",

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
                          child: Text("CADASTRAR",
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

          ],
        ),
      ),
    );
  }
}
