import 'package:flutter/material.dart';

enum DIRECTION { up, down }

class RouteTransitions {
  static Route createRoute(route, DIRECTION direction) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => route,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var _begin = Offset(0.0, 1.0);
        var _end = Offset.zero;

        switch (direction) {
          case DIRECTION.up:
            {
              _begin = Offset(0.0, 1.0);
              _end = Offset.zero;
            }
            break;
          case DIRECTION.down:
            {
              _begin = Offset(0.0, -1.0);
              _end = Offset.zero;
            }
            break;
        }

        var _tween = Tween(begin: _begin, end: _end).chain(
          CurveTween(curve: Curves.ease),
        );

        return SlideTransition(
          position: animation.drive(_tween),
          child: child,
        );
      },
    );
  }
}
