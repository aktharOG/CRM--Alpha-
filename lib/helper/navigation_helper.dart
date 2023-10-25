import 'package:crm_new/helper/animated_navigation.dart';
import 'package:flutter/material.dart';

push(BuildContext context, page) {
  Navigator.push(
    context,
    createRoute(page)
  );
}

pushAndReplace(BuildContext context, page) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => page,
    ),
  );
}


pushAndRemoveUntil(BuildContext context, page) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (_) => page,
    ),
    (_) => false,
  );
}

pop(BuildContext context){
  Navigator.pop(context);
}
