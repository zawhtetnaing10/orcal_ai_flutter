import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orcal_ai_flutter/utils/dimens.dart';
import 'package:orcal_ai_flutter/utils/images.dart' show Images;

import '../utils/colors.dart';
import '../widgets/orcal_password_input.dart';
import '../widgets/orcal_primary_button.dart';
import '../widgets/orcal_textfield.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.chevron_left, color: Colors.white, size: kMarginXXLarge,),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kMarginMedium2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Images.kAppLogo,
                  width: kLogoSize,
                  height: kLogoSize,
                ),

                Padding(
                  padding: EdgeInsets.only(top: kMargin40),
                  child: Text(
                    "Create Account!",
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

                /// Name
                Padding(
                  padding: EdgeInsets.only(top: kMarginMedium2),
                  child: SizedBox(
                    width: double.infinity,
                    child: OrcalTextField(
                      label: "Name",
                      hint: "Jack",
                      onTextChanged: (email) {},
                    ),
                  ),
                ),

                /// Create Account Button
                Padding(
                  padding: EdgeInsets.only(top: kMarginXXLarge),
                  child: SizedBox(
                    width: double.infinity,
                    height: kMarginXXLarge,
                    child: OrcalPrimaryButton(
                      label: "Create Account",
                      onPressed: () {},
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
