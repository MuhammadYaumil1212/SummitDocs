import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TransitionType {
  slide,
  fade,
  slideAndFade,
}

/// if you wanna change the transition,
/// just add new transition type and add it to _buildTransition
class AppNavigator {
  static void pushReplacement(BuildContext context, Widget widget,
      {TransitionType transitionType = TransitionType.slide}) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return _buildTransition(animation, child, transitionType);
        },
      ),
    );
  }

  static void push(BuildContext context, Widget widget,
      {TransitionType transitionType = TransitionType.slide}) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return _buildTransition(animation, child, transitionType);
        },
      ),
    );
  }

  static void pushAndRemove(BuildContext context, Widget widget,
      {TransitionType transitionType = TransitionType.slide}) {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return _buildTransition(animation, child, transitionType);
        },
      ),
      (Route<dynamic> route) => false,
    );
  }

  static Widget _buildTransition(Animation<double> animation, Widget child,
      TransitionType transitionType) {
    const begin = Offset(1.0, 0.0); // Mulai dari kanan layar
    const end = Offset.zero; // Berakhir di posisi normal
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
