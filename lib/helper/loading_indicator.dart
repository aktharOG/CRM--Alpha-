import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingIC extends StatelessWidget {
  const LoadingIC({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: LottieBuilder.asset("assets/animation_lmoqaxnn.json",height: 80,),);
  }
}