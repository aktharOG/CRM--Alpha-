// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:crm_new/helper/navigation_helper.dart';
import 'package:crm_new/services/api/api_method_setup.dart';
import 'package:crm_new/services/cache/shared_pref_service.dart';
import 'package:crm_new/src/home/screens/home_screen.dart';
import 'package:crm_new/src/login/screens/login.dart';
import 'package:crm_new/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 String? tokenFromShared;

  timeerFun()async{
     Timer(const Duration(seconds: 1), () async{ 
       tokenFromShared =  SharedPreferencesService.prefs.getString("token");
       if(tokenFromShared!=null){
       await ApiService.dioInitializerAndSetter(token: tokenFromShared.toString());
        pushAndRemoveUntil(context,const  HomeScreen());
       }else{
        pushAndRemoveUntil(context, const LoginScreen());
       }

     });
  }
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeerFun();
  }
 
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child:  SvgIcon(path: "logo_full"),),
    );
  }
}