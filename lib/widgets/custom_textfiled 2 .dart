// ignore_for_file: file_names

import 'package:crm_new/src/login/provider/login_provider.dart';
import 'package:crm_new/theme/app_theme.dart';
import 'package:crm_new/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurstomTextfield2 extends StatelessWidget {
  final String label, hint, iconPath;
  final TextEditingController controller;
  final bool isPassword;
  final BorderRadius borderRadius;
  final double maxLine;

  const CurstomTextfield2(
      {super.key,
      required this.label,
      required this.hint,
      required this.controller,
      this.isPassword = false,
      required this.borderRadius,
      this.iconPath = "",
      this.maxLine = 60});

  @override
  Widget build(BuildContext context) {
    final loginPro = Provider.of<LoginProvider>(context);
    return SizedBox(
      height: maxLine,
      child: TextField(
        maxLines: isPassword ? 1 : maxLine.toInt(),
        keyboardType: isPassword ? TextInputType.visiblePassword : null,
        obscureText: isPassword ? loginPro.visibility : false,
        controller: controller,
        decoration: InputDecoration(
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
                    child: SvgIcon(path: iconPath,color: appBlue,fixedColor: appBlue,height: 10,width: 20,),
                  ),
                  
            disabledBorder: const OutlineInputBorder(),
            border: OutlineInputBorder(borderRadius: borderRadius),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}
