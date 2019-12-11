import 'package:flare_demo/smart_flare_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlareDemo extends StatefulWidget {
  @override
  _FlareDemoState createState() => _FlareDemoState();
}

class _FlareDemoState extends State<FlareDemo> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Align (
        alignment: Alignment.bottomCenter,
          child: SmartFlareAnimation(),),
    );
  }
}
