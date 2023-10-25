import 'package:crm_new/theme/app_theme.dart';
import 'package:crm_new/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;
  final double height,width;
  final Color? color;
  final Color? textColor;
  final String? iconPath;
  const CustomButton({super.key,required this.name,required this.onPressed,this.height =45,this.width =120,this.color,this.textColor,this.iconPath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: MaterialButton(
                      elevation: 0,
                      height: height,
                      minWidth: width,
                      onPressed: onPressed,
                      color: color?? appBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if(iconPath!=null)
                          SvgIcon(path: iconPath!),
                          if(iconPath!=null)
                          const SizedBox(width: 5,),
                          Text(
                            name,
                            style:  TextStyle(color: textColor?? Colors.white,fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
    );
  }
}