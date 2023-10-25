import 'package:flutter/material.dart';

Route createRoute( route) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => route  ,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // const begin = Offset(0.0, 1.0);
      // const end = Offset.zero;
      // const curve = Curves.ease;

      // var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return FadeTransition(
        opacity: animation,
      //  position: animation.drive(tween),
        child: child,
      );
    },
  );
}