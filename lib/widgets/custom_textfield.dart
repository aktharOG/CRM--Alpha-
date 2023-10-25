import 'package:crm_new/src/login/provider/login_provider.dart';
import 'package:crm_new/theme/app_theme.dart';
import 'package:crm_new/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurstomTextfield extends StatelessWidget {
  final String label, hint, iconPath;
  final TextEditingController controller;
  final bool isPassword;
  final BorderRadius? borderRadius;
  final double? maxLine;
  final bool readOnly;
  final Function()? onTap;
 final Function(String)? onChanged;
  final bool isNumber;

  const CurstomTextfield(
      {super.key,
      required this.label,
      required this.hint,
      required this.controller,
      this.isPassword = false,
       this.borderRadius,
      this.iconPath = "",
      this.maxLine,
      this.readOnly = false,
      this.onTap,
      this.onChanged,
      this.isNumber = false
      
      });

  @override
  Widget build(BuildContext context) {
    final loginPro = Provider.of<LoginProvider>(context);
    return Material(
      child: SizedBox(
        height: maxLine,
        child: TextField(
          onChanged: onChanged,
          
          onTap: onTap,
          readOnly: readOnly,
          maxLines: isPassword ? 1 : maxLine?.toInt()?? 1,
          keyboardType: isPassword ? TextInputType.visiblePassword : isNumber?TextInputType.number:null ,
          obscureText: isPassword ? loginPro.visibility : false,
          controller: controller,
          decoration: InputDecoration(
            
            enabledBorder:OutlineInputBorder(
              borderSide:  BorderSide(color: appBlue, width: 1.0),
              borderRadius:borderRadius ?? BorderRadius.circular( 10.0),
            ),
              suffixIcon: iconPath.isEmpty
                  ? isPassword
                      ? InkWell(
                          onTap: loginPro.onVisible,
                          child: !loginPro.visibility
                              ? Icon(
                                  Icons.visibility_outlined,
                                  color: appBlue,
                                )
                              : Icon(
                                  Icons.visibility_off_outlined,
                                  color: appBlue,
                                ))
                      : null
                  : Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: CircleAvatar(child: SvgIcon(path: iconPath)),
                    ),
              
              disabledBorder:  OutlineInputBorder(borderRadius: borderRadius!),
              border: OutlineInputBorder(borderRadius: borderRadius!),
             // focusedBorder: OutlineInputBorder(borderRadius: borderRadius),
              
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey)),
        ),
      ),
    );
  }
}
