import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final bool value;
  final String status;
  final void Function(bool?)? onChanged;
  final Color? color;

  const CustomCheckBox({super.key,required this.onChanged,required this.value,this.status="Completed",this.color});

  @override
  Widget build(BuildContext context) {
    return   Row(
                    //    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                       Text(
                        status,
                        style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),
                      ),

                      Checkbox(
                          
                          activeColor:color?? Colors.green,
                          value: value,
                          onChanged: onChanged),
                    ],
                  );
  }
}