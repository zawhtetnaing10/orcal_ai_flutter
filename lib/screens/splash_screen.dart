import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:orcal_ai_flutter/blocs/splash_bloc.dart';
import 'package:orcal_ai_flutter/states/splash_state.dart';
import 'package:orcal_ai_flutter/utils/colors.dart';
import 'package:orcal_ai_flutter/utils/dimens.dart';
import 'package:orcal_ai_flutter/utils/images.dart';
import 'package:orcal_ai_flutter/utils/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SplashBloc(),
      child: SplashScreenBody(),
    );
  }
}

class SplashScreenBody extends StatelessWidget {
  const SplashScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listenWhen: (prev, curr) => prev.event != curr.event,
      listener: (context, state) {
        switch (state.event) {
          case SplashEvents.initial:
            break;
          case SplashEvents.navigateToLogin:
            context.goNamed(kLoginRoute);
            break;
          case SplashEvents.navigateToHome:
            context.goNamed(kHomeRoute);
            break;
          case SplashEvents.navigateToAddKnowledgeBase:
            context.goNamed(kAddKnowledgeBaseOneRoute);
            break;
        }
      },
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Image.asset(
              Images.kAppLogo,
              width: kLogoSize,
              height: kLogoSize,
            ),
          ),
        ),
      ),
    );
  }
}
