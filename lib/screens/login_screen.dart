import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orcal_ai_flutter/utils/colors.dart';
import 'package:orcal_ai_flutter/utils/dimens.dart';
import 'package:orcal_ai_flutter/utils/images.dart';
import 'package:orcal_ai_flutter/utils/routes.dart';
import 'package:orcal_ai_flutter/widgets/orcal_password_input.dart';
import 'package:orcal_ai_flutter/widgets/orcal_primary_button.dart';
import 'package:orcal_ai_flutter/widgets/orcal_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kMarginMedium2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 72),
                  child: Image.asset(
                    Images.kAppLogo,
                    width: kLogoSize,
                    height: kLogoSize,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: kMargin40),
                  child: Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: kTextBig,
                    ),
                  ),
                ),

                /// Email
                Padding(
                  padding: EdgeInsets.only(top: kMarginXLarge),
                  child: SizedBox(
                    width: double.infinity,
                    child: OrcalTextField(
                      label: "Email",
                      hint: "example@gmail.com",
                      onTextChanged: (email) {},
                    ),
                  ),
                ),

                /// Password
                Padding(
                  padding: EdgeInsets.only(top: kMarginMedium2),
                  child: SizedBox(
                    width: double.infinity,
                    child: OrcalPasswordInput(
                      label: "Password",
                      hint: "@Snl#af8",
                      onTextChanged: (password) {},
                    ),
                  ),
                ),

                /// Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ),
                ),

                /// Login Button
                Padding(
                  padding: EdgeInsets.only(top: kMarginXLarge),
                  child: SizedBox(
                    width: double.infinity,
                    height: kMarginXXLarge,
                    child: OrcalPrimaryButton(
                      label: "Log in",
                      onPressed: () {
                        context.pushNamed(kRegisterRoute);
                      },
                    ),
                  ),
                ),

                /// Don't have an account?
                Padding(
                  padding: EdgeInsets.only(top: kMarginLarge),
                  child: Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: kTextRegular,
                    ),
                  ),
                ),

                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: kTextRegular3X,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
