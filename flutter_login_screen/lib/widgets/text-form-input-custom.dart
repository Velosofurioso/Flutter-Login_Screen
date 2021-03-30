import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:validators/validators.dart';

class TextFormInputCustom extends StatefulWidget {

  final IconData icon;
  final String placeholder;
  final String Function(String) validation;
  final TextInputType inputType;
  final bool isPassword;
  final TextEditingController controller;


  const TextFormInputCustom ({Key key, this.icon, this.placeholder,
                              this.validation, this.inputType, this.isPassword,
                              this.controller}): super(key: key);

  @override
  _TextFormInputCustomState createState() => _TextFormInputCustomState();
}

class _TextFormInputCustomState extends State<TextFormInputCustom> {

  FocusNode _focusNode = new FocusNode();

  OutlineInputBorder _decorationBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      borderSide: BorderSide(
          color: _focusNode.hasFocus
              ? Color.fromARGB(255, 1, 191, 165)
              : Theme
              .of(context)
              .primaryColor
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(left: 25.0, right: 40.0),
      child: TextFormField(
        controller: widget.controller,
        style: TextStyle(color: Colors.white),
        obscureText: widget.isPassword == true ? true : false,
        focusNode: _focusNode,
        keyboardType: widget.inputType ?? TextInputType.text,
        validator: (value)  => widget.validation(value),

        decoration: InputDecoration(
            focusedErrorBorder: _decorationBorder(),
            focusedBorder: _decorationBorder(),
            prefixIcon: Icon(widget.icon, color: Colors.grey[600]),
            hintText: widget.placeholder,
            hintStyle: TextStyle(color: Colors.grey[600], fontSize: 15.0)
        ),

        onTap: () { setState(() {}); },

      ),
    );
  }
}
