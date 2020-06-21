import 'package:Assignment/configuration.dart';
import 'package:flutter/material.dart';


Widget showProgress() {
  return Center(
    child: Stack(
      children: <Widget>[
        Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: new AlwaysStoppedAnimation<Color>(appColor),
            ),
          ),
        ),
      ],
    ),
  );
}


