import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TransitionType {
  slide,
  fade,
  slideAndFade,
}

enum SlideType {
  left,
  right,
}

/// if you wanna change the transition,
/// just add new transition type and add it to _buildTransition
class AppNavigator {
  static void pushReplacement(
    BuildContext context,
    Widget widget, {
    TransitionType transitionType = TransitionType.slide,
    SlideType slideType = SlideType.right,
  }) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return _buildTransition(animation, child, transitionType, slideType);
        },
      ),
    );
  }

  static void push(BuildContext context, Widget widget,
      {TransitionType transitionType = TransitionType.slide,
      SlideType slideType = SlideType.right}) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return _buildTransition(animation, child, transitionType, slideType);
        },
      ),
    );
  }

  static void pushAndRemove(BuildContext context, Widget widget,
      {TransitionType transitionType = TransitionType.slide,
      SlideType slideType = SlideType.right}) {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return _buildTransition(animation, child, transitionType, slideType);
        },
      ),
      (Route<dynamic> route) => false,
    );
  }

  static Widget _buildTransition(Animation<double> animation, Widget child,
      TransitionType transitionType, SlideType slideType) {
    Offset begin = slideType == SlideType.right
        ? const Offset(1.0, 0.0) // Dari kanan ke kiri (default)
        : const Offset(-1.0, 0.0); // Dari kiri ke kanan

    const end = Offset.zero;
    const curve = Curves.easeInOut;

    var slideTween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var slideAnimation = animation.drive(slideTween);

    var fadeTween = Tween(begin: 0.0, end: 1.0);
    var fadeAnimation = animation.drive(fadeTween);

    switch (transitionType) {
      case TransitionType.slide:
        return SlideTransition(position: slideAnimation, child: child);
      case TransitionType.fade:
        return FadeTransition(opacity: fadeAnimation, child: child);
      case TransitionType.slideAndFade:
        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(position: slideAnimation, child: child),
        );
    }
  }
}
