import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:orcal_ai_flutter/actions/add_knowledge_base_three_actions.dart';
import 'package:orcal_ai_flutter/blocs/add_knowledge_base_three_bloc.dart';
import 'package:orcal_ai_flutter/states/add_knowledge_base_three_state.dart';
import 'package:orcal_ai_flutter/utils/colors.dart';
import 'package:orcal_ai_flutter/utils/dimens.dart';
import 'package:orcal_ai_flutter/utils/routes.dart';
import 'package:orcal_ai_flutter/utils/strings.dart';
import 'package:orcal_ai_flutter/utils/widget_utils.dart';
import 'package:orcal_ai_flutter/widgets/orcal_primary_button.dart';
import 'package:orcal_ai_flutter/widgets/orcal_text_area.dart'
    show OrcalTextArea;

class AddKnowledgeBaseThreeScreen extends StatelessWidget {
  const AddKnowledgeBaseThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AddKnowledgeBaseThreeBloc(),
      child: AddKnowledgeBaseThreeBody(),
    );
  }
}

class AddKnowledgeBaseThreeBody extends StatelessWidget {
  const AddKnowledgeBaseThreeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddKnowledgeBaseThreeBloc, AddKnowledgeBaseThreeState>(
      listenWhen: (previous, current) => previous.events != current.events,
      listener: (context, state) {
        switch (state.events) {
          case AddKnowledgeBaseThreeEvents.initial:
            break;
          case AddKnowledgeBaseThreeEvents.showLoading:
            showLoadingDialog(context);
            break;
          case AddKnowledgeBaseThreeEvents.dismissLoading:
            Navigator.pop(context);
            break;
          case AddKnowledgeBaseThreeEvents.showSuccessDialog:
            showBuildKnowledgeBaseSuccessDialog(
              context: context,
              onTapOk: () {
                context.read<AddKnowledgeBaseThreeBloc>().onAction(
                  OnConfirmKnowledgeBaseSuccessful(),
                );
              },
            );
            break;
          case AddKnowledgeBaseThreeEvents.navigateToHome:
            context.goNamed(kHomeRoute);
            break;
          case AddKnowledgeBaseThreeEvents.showError:
            showErrorDialog(
              context: context,
              errorMessage: state.errorMessage,
              onTapOk: () {
                context.read<AddKnowledgeBaseThreeBloc>().onAction(
                  OnAddKnowledgeBaseThreeDismissDialog(),
                );
              },
            );
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
              size: kMarginXLarge,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kMarginCardMedium2),
              child: Text(
                "3/3",
                style: TextStyle(color: Colors.white, fontSize: kTextRegular2X),
              ),
            ),
          ],
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kMarginMedium2),
                child: Text(
                  kLetsBuildOurKnowledgeBase,
                  style: TextStyle(
                    fontSize: kTextBig,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  top: kMarginMedium3,
                  left: kMarginMedium2,
                  right: kMarginMedium2,
                ),
                child: OrcalTextArea(
                  label:
                      "What topics are you currently obsessed with or learning?",
                  hint: "Topics currently learning...",
                  onChanged: (topicsCurrentlyLearning) {
                    context.read<AddKnowledgeBaseThreeBloc>().onAction(
                      OnTopicsCurrentlyLearningChanged(
                        topicsCurrentlyLearning: topicsCurrentlyLearning,
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  top: kMarginMedium3,
                  left: kMarginMedium2,
                  right: kMarginMedium2,
                ),
                child: OrcalTextArea(
                  label:
                      "What are your work boundaries? (Things you want to avoid)",
                  hint: "Things to avoid...",
                  onChanged: (workBoundaries) {
                    context.read<AddKnowledgeBaseThreeBloc>().onAction(
                      OnWorkBoundariesChanged(workBoundaries: workBoundaries),
                    );
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  top: kMarginXLarge,
                  left: kMarginMedium2,
                  right: kMarginMedium2,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: kMarginXXLarge,
                  child: OrcalPrimaryButton(
                    label: kBuildKnowledgeBase,
                    onPressed: () {
                      context.read<AddKnowledgeBaseThreeBloc>().onAction(
                        OnTapBuildKnowledgeBase(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
