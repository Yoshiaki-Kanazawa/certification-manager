import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 60,
          color: Colors.grey[200],
          child: Column(
            children: <Widget>[
              Text('first line'),
              Text('second line'),
            ],
          ),
        ),
      ],
    );
  }
}
