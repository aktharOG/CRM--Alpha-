import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crm_new/helper/navigation_helper.dart';
import 'package:crm_new/src/home/screens/home_screen.dart';
import 'package:crm_new/widgets/custom_button.dart';
import 'package:crm_new/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NetworkConnectionScreen extends StatelessWidget {
  const NetworkConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          const HeadingText(name: "No Internet Connection",fontweight: FontWeight.bold,fontsize: 20,),
          const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: CustomButton(
              width: MediaQuery.of(context).size.width,
              name: "Check Again", onPressed: ()async{
                final connectivityResult = await (Connectivity().checkConnectivity());
                if(connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi){
              push(context,const HomeScreen());

                }else{
              Fluttertoast.cancel();
              Fluttertoast.showToast(msg: "No Internet Connection");
                }
            }),
          )
        ],
      ),),
    );
  }
}