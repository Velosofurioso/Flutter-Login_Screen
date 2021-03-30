import 'package:flutter/material.dart';

class RecoverySelector extends StatefulWidget {
  final String text;
  final IconData icon;
  final int value;
  int type;
  final void Function(int) onChange;

  RecoverySelector(this.text, this.icon, this.value, this.onChange, this.type);

  @override
  _RecoverySelectorState createState() => _RecoverySelectorState();
}

class _RecoverySelectorState extends State<RecoverySelector> {

  //int _type = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Color.fromARGB(255, 1, 191, 165),

        child: Container(
          width: 130.0,
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Icon(widget.icon, color: Theme.of(context).primaryColor,),

              SizedBox(height: 5.0),

              Text(widget.text, style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700),
              ),

              Radio(value: widget.value, groupValue: widget.type,
                  onChanged: (val) {
                      widget.onChange(val);
                  }
              ),

            ],
          ),
        )
    );
  }
}