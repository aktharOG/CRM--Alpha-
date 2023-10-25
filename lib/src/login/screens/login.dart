import 'package:crm_new/helper/custom_snackbar.dart';
import 'package:crm_new/helper/loading_indicator.dart';
import 'package:crm_new/src/login/provider/login_provider.dart';
import 'package:crm_new/widgets/custom_button.dart';
import 'package:crm_new/widgets/custom_textfield.dart';
import 'package:crm_new/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginPro = Provider.of<LoginProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SvgIcon(path: "logo_full"),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Sign In To Your Account",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  CurstomTextfield(
                      borderRadius: BorderRadius.circular(10),
                      label: "",
                      hint: "Username",
                      controller: loginPro.usernameController),
                  const SizedBox(
                    height: 20,
                  ),
                  CurstomTextfield(
                    borderRadius: BorderRadius.circular(10),
                    label: "",
                    hint: "Password",
                    controller: loginPro.passwordController,
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  loginPro.isLogin
                      ? const SizedBox(height: 50, child: LoadingIC())
                      : CustomButton(
                          width: 130,
                          name: "Sign In",
                          onPressed: () {
                            if (loginPro.usernameController.text.isEmpty) {
                              customSnackbar(
                                  context, "Enter username", "", () {});
                            } else if (loginPro
                                .passwordController.text.isEmpty) {
                              customSnackbar(
                                  context, "Enter password", "", () {});
                            } else {
                              loginPro.onLoginAPi(context);
                            }
                            //  push(context, const HomeScreen());
                          })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
