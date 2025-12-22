import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:orcal_ai_flutter/actions/create_account_actions.dart';
import 'package:orcal_ai_flutter/blocs/create_account_bloc.dart';
import 'package:orcal_ai_flutter/states/create_account_state.dart';
import 'package:orcal_ai_flutter/utils/dimens.dart';
import 'package:orcal_ai_flutter/utils/images.dart' show Images;
import 'package:orcal_ai_flutter/utils/widget_utils.dart';

import '../utils/colors.dart';
import '../widgets/orcal_password_input.dart';
import '../widgets/orcal_primary_button.dart';
import '../widgets/orcal_textfield.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CreateAccountBloc(),
      child: CreateAccountBody(),
    );
  }
}

class CreateAccountBody extends StatelessWidget {
  const CreateAccountBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateAccountBloc, CreateAccountState>(
      listenWhen: (previous, curr) => previous.event != curr.event,
      listener: (context, state) {
        switch (state.event) {
          case CreateAccountEvents.initial:
            break;
          // Do Nothing
          case CreateAccountEvents.showLoading:
            showLoadingDialog(context);
            break;
          case CreateAccountEvents.dismissLoading:
            Navigator.pop(context);
            break;
          case CreateAccountEvents.navigateBack:
            Navigator.pop(context);
            break;
          case CreateAccountEvents.navigateToHome:
            debugPrint("Navigate to home");
            break;
          case CreateAccountEvents.showError:
            showErrorDialog(
              context: context,
              errorMessage: state.errorMessage,
              onTapOk: () {
                context.read<CreateAccountBloc>().onAction(
                  OnCreateAccountDismissDialog(),
                );
              },
            );
            break;
        }
      },
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(
              Icons.chevron_left,
              color: Colors.white,
              size: kMarginXXLarge,
            ),
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
                      child: OrcalTextFieldWithLabel(
                        label: "Email",
                        hint: "example@gmail.com",
                        onTextChanged: (email) {
                          context.read<CreateAccountBloc>().onAction(
                            OnCreateAccountEmailChanged(email),
                          );
                        },
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
                        onTextChanged: (password) {
                          context.read<CreateAccountBloc>().onAction(
                            OnCreateAccountPasswordChanged(password),
                          );
                        },
                      ),
                    ),
                  ),

                  /// Name
                  Padding(
                    padding: EdgeInsets.only(top: kMarginMedium2),
                    child: SizedBox(
                      width: double.infinity,
                      child: OrcalTextFieldWithLabel(
                        label: "Name",
                        hint: "Jack",
                        onTextChanged: (userName) {
                          context.read<CreateAccountBloc>().onAction(
                            OnCreateAccountUserNameChanged(userName),
                          );
                        },
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
                        onPressed: () {
                          context.read<CreateAccountBloc>().onAction(
                            OnTapCreateAccount(),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
