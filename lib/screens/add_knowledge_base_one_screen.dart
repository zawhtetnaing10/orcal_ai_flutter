import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:orcal_ai_flutter/actions/add_knowledge_base_one_actions.dart';
import 'package:orcal_ai_flutter/blocs/add_knowledge_base_one_bloc.dart';
import 'package:orcal_ai_flutter/states/add_knowledge_base_one_state.dart';
import 'package:orcal_ai_flutter/utils/colors.dart';
import 'package:orcal_ai_flutter/utils/dimens.dart';
import 'package:orcal_ai_flutter/utils/routes.dart';
import 'package:orcal_ai_flutter/utils/strings.dart';
import 'package:orcal_ai_flutter/utils/widget_utils.dart';
import 'package:orcal_ai_flutter/widgets/orcal_primary_button.dart';
import 'package:orcal_ai_flutter/widgets/orcal_text_area.dart'
    show OrcalTextArea;
import 'package:orcal_ai_flutter/widgets/orcal_textfield_with_label.dart';
import 'package:orcal_ai_flutter/widgets/orcal_timezone_picker.dart';

class AddKnowledgeBaseOneScreen extends StatelessWidget {
  const AddKnowledgeBaseOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AddKnowledgeBaseOneBloc(),
      child: AddKnowledgeBaseOneBody(),
    );
  }
}

class AddKnowledgeBaseOneBody extends StatelessWidget {
  const AddKnowledgeBaseOneBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddKnowledgeBaseOneBloc, AddKnowledgeBaseOneState>(
      listenWhen: (previous, curr) => previous.events != curr.events,
      listener: (BuildContext context, AddKnowledgeBaseOneState state) {
        switch (state.events) {
          case AddKnowledgeBaseOneEvents.initial:
            break;
          case AddKnowledgeBaseOneEvents.showLoading:
            showLoadingDialog(context);
            break;
          case AddKnowledgeBaseOneEvents.dismissLoading:
            Navigator.of(context).pop();
            break;
          case AddKnowledgeBaseOneEvents.navigateToStepTwo:
            context.pushNamed(kAddKnowledgeBaseTwoRoute);
            break;
          case AddKnowledgeBaseOneEvents.showError:
            showErrorDialog(
              context: context,
              errorMessage: state.errorMessage,
              onTapOk: () {
                context.read<AddKnowledgeBaseOneBloc>().onAction(
                  OnAddKnowledgeBaseOneDismissDialog(),
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
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kMarginCardMedium2),
              child: Text(
                "1/3",
                style: TextStyle(color: Colors.white, fontSize: kTextRegular2X),
              ),
            ),
          ],
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kMarginMedium2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  kLetsBuildOurKnowledgeBase,
                  style: TextStyle(
                    fontSize: kTextBig,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: kMarginMedium3),
                  child: OrcalTextFieldWithLabel(
                    label: "What is your full name and preferred nickname?",
                    hint: "Your full name and nick name...",
                    onTextChanged: (identityAnswer) {
                      context.read<AddKnowledgeBaseOneBloc>().onAction(
                        OnIdentityAnswerChanged(identityAnswer: identityAnswer),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: kMarginMedium3),
                  child: OrcalTextArea(
                    label:
                        "How do you describe your professional role or \"vibe\" in one sentence?",
                    hint: "Your professional role...",
                    onChanged: (workPersonaAnswer) {
                      context.read<AddKnowledgeBaseOneBloc>().onAction(
                        OnWorkPersonaAnswerChanged(
                          workPersonaAnswer: workPersonaAnswer,
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: kMarginMedium3),
                  child: OrcalTimezonePicker(
                    label:
                        "Where are you based, and what is your current timezone?",
                    hint: "Timezone...",
                    onTimezonePicked: (timezoneAnswer) {
                      context.read<AddKnowledgeBaseOneBloc>().onAction(
                        OnTimezoneAnswerChanged(timezoneAnswer: timezoneAnswer),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: kMarginXLarge),
                  child: SizedBox(
                    width: double.infinity,
                    height: kMarginXXLarge,
                    child: OrcalPrimaryButton(
                      label: kNext,
                      onPressed: () {
                        context.read<AddKnowledgeBaseOneBloc>().onAction(
                          OnTapNext(),
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
    );
  }
}
