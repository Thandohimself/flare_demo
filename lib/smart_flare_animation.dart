import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/cupertino.dart';

enum AnimationToPlay {
  Activate,
  Deactivate,
  CameraTapped,
  PulseTapped,
  ImageTapped
}

class SmartFlareAnimation extends StatefulWidget {
  @override
  _SmartFlareAnimationState createState() => _SmartFlareAnimationState();
}

class _SmartFlareAnimationState extends State<SmartFlareAnimation> {

  //create our flare controls
  final FlareControls animationControls = FlareControls();

  AnimationToPlay _animationToPlay = AnimationToPlay.Deactivate;
  AnimationToPlay _lastPlayedAnimation;


  //width and height retrieved from the artboard values in the animation

  static const double AnimationWidth = 295.0;
  static const double AnimationHeight = 295.0;

  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AnimationWidth,
      height: AnimationHeight,
      child: GestureDetector(
        onTapUp: (tapInfo){

          setState(() {
          var localTouchPosition = (context.findRenderObject() as RenderBox).globalToLocal(tapInfo.globalPosition);

          //Where did we touch
          var topHalfTouched =  localTouchPosition.dy < AnimationHeight / 2;

          var leftSideTouched = localTouchPosition.dx <AnimationWidth /3;

          var rightSideTouched = localTouchPosition.dx > (AnimationWidth / 3) * 2;

          var middleTouched = !leftSideTouched && !rightSideTouched;

          if(leftSideTouched && topHalfTouched){
            print('TopLeft');
            _setAnimationToPlay(AnimationToPlay.CameraTapped);
          }else if(middleTouched && topHalfTouched){
            print('TopMiddle');
            _setAnimationToPlay(AnimationToPlay.PulseTapped);
          }else if (rightSideTouched && topHalfTouched){
            print('TopRight');
            _setAnimationToPlay(AnimationToPlay.ImageTapped);
          }else{
            if(isOpen){
              print('Bottom Close');
              _setAnimationToPlay(AnimationToPlay.Deactivate);
            }else{
              print('Bottom Open');
              _setAnimationToPlay(AnimationToPlay.Activate);
            }
            isOpen = !isOpen;
          }

          });
        },
        child: FlareActor('assets/button-animation.flr',
          controller: animationControls,
          animation: _getAnimationName(_animationToPlay),
        ),
      ),
    );
  }
  String _getAnimationName(AnimationToPlay animationToPlay){
    switch(animationToPlay){
      case AnimationToPlay.Activate:
        return 'activate';
      case AnimationToPlay.Deactivate:
        return 'deactivate';
      case AnimationToPlay.CameraTapped:
        return 'camera_tapped';
      case AnimationToPlay.PulseTapped:
        return 'pulse_tapped';
      case AnimationToPlay.ImageTapped:
        return 'image_tapped';
      default:
        return 'deactivate';
    }
  }

  void _setAnimationToPlay(AnimationToPlay animation){

    var isTappedAnimation = _getAnimationName(animation).contains('_tapped');

    if(isTappedAnimation && _lastPlayedAnimation == AnimationToPlay.Deactivate){
      return;
    }
    animationControls.play(_getAnimationName(animation));

    //remember our last played animation
    _lastPlayedAnimation = animation;

  }
}
