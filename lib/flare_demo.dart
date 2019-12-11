import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_flare/actors/smart_flare_actor.dart';
import 'package:smart_flare/models.dart';

class FlareDemo extends StatefulWidget {
  @override
  _FlareDemoState createState() => _FlareDemoState();
}

class _FlareDemoState extends State<FlareDemo> {

  @override
  Widget build(BuildContext context) {

    var animationHeight = 251.0;
    var animationWidth = 295.0;

    var animationWithThirds = animationWidth / 3;
    var animationWithHeight = animationWidth / 2;


    var activeAreas = [

      //Top left area
      ActiveArea(
        area: Rect.fromLTWH(0, 0, animationWithThirds, animationWithHeight),
        animationName: 'camera_tapped',
        guardComingFrom: ['deactivate']
      ),

      //Top middle area
      ActiveArea(
          area: Rect.fromLTWH(animationWithThirds, 0, animationWithThirds, animationWithHeight),
          animationName: 'pulse_tapped',
          guardComingFrom: ['deactivate']
      ),

      //Top middle area
      ActiveArea(
          area: Rect.fromLTWH(animationWithThirds * 2, 0, animationWithThirds, animationWithHeight),
          animationName: 'image_tapped',
          guardComingFrom: ['deactivate']
      ),


      ActiveArea(area: Rect.fromLTWH(
        0,
        animationHeight / 2,
        animationWidth,
        animationHeight / 2),
        animationsToCycle:  ['activate', 'deactivate'],
        onAreaTapped: (){
        print('Toggle animation!');
        })
    ];

    return Scaffold(
      backgroundColor: Colors.amber,
      body: Align (
        alignment: Alignment.bottomCenter,
          child: SmartFlareActor(
            width: animationWidth,
            height: animationHeight,
            filename: 'assets/button-animation.flr',
            startingAnimation: 'deactivate',
            activeAreas: activeAreas,
          ),),
    );
  }
}
