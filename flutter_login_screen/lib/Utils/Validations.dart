import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class Validations {


  static String isValidEmail(value) {

    if (!isEmail(value)) {
      return Text("Digite um Email valido",
          style: TextStyle(color: Colors.white)).data;
    }
    else {
      return null;
    }
  }

  static String isEmpty(value) {
    if(value.isEmpty) {
      return Text("Preencha o campo",
          style: TextStyle(color: Colors.white)).data;
    }
    else {
      return null;
    }
  }

  static String isValidNumber(value) {

    if (!isLength(value, 11)) {
      return Text("Digite um Numero valido",
          style: TextStyle(color: Colors.white)).data;
    }
    else {
      return null;
    }
  }
}