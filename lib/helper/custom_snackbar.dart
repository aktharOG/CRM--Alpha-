import 'package:crm_new/widgets/custom_text.dart';
import 'package:flutter/material.dart';

void customSnackbar(BuildContext context,String message,String label,VoidCallback onPressed) {
    final snackBar = SnackBar(
      
      duration:const Duration(seconds: 3),
      dismissDirection: DismissDirection.startToEnd,
      content: Text(message),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(label: label, onPressed: onPressed),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  class CustomSnackBarNEW extends StatelessWidget {
    final String message;
    final String? label;
    final VoidCallback onPressed;
    final Duration duration;
  const CustomSnackBarNEW({super.key,required this.message,this.label, required this.onPressed,this.duration = const Duration(milliseconds: 500)});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      duration: duration,
      dismissDirection: DismissDirection.startToEnd,
      content: HeadingText(name: message),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(label: label!, onPressed: onPressed),
    );
  }
}

  // Color(0xffFFDA63)