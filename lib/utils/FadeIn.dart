import 'package:simple_animations/simple_animations.dart';
import 'package:flutter/material.dart';

class FadeIn extends StatelessWidget {
  final Widget child;
  final double delay;

  FadeIn(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    
    final _tween = MultiTrackTween([
      Track("opacity")
          .add(Duration(milliseconds: 200), Tween(begin: 0.0, end: 1.0)),
      Track("translateY").add(
          Duration(milliseconds: 200), Tween(begin: 90.0, end: 0.0),
          curve: Curves.easeOut)
    ]);

    return ControlledAnimation(
      // delay: Duration(milliseconds: delay.round()),
      delay: Duration(milliseconds: (200 * delay).round()),
      duration: _tween.duration,
      tween: _tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
          offset: Offset(0, animation["translateY"]),
          child: child,
        ),
      ),
    );
  }
}
