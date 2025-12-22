import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orcal_ai_flutter/utils/colors.dart';
import 'package:orcal_ai_flutter/utils/dimens.dart';
import 'package:orcal_ai_flutter/utils/routes.dart';
import 'package:orcal_ai_flutter/utils/strings.dart';
import 'package:orcal_ai_flutter/widgets/orcal_multiple_text_fields.dart';
import 'package:orcal_ai_flutter/widgets/orcal_primary_button.dart';
import 'package:orcal_ai_flutter/widgets/orcal_radio_buttons.dart';
import 'package:orcal_ai_flutter/widgets/orcal_text_area.dart';

class AddKnowledgeBaseTwoScreen extends StatelessWidget {
  const AddKnowledgeBaseTwoScreen({super.key});

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
              "2/3",
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
                label: "What are your primary technical skills and tools?",
                hint: "Your primary skills and tools...",
                onChanged: (input) {},
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                top: kMarginMedium3,
                left: kMarginMedium2,
                right: kMarginMedium2,
              ),
              child: OrcalMultipleTextFields(
                label: "What are your current top 3 professional goals?",
                count: 3,
                hint: "Professional Goal...",
                onInputChanged: (inputs) {},
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: kMarginMedium3),
              child: OrcalRadioButtons(
                innerPadding: kMarginMedium2,
                label: "When are you most productive?",
                items: [
                  "5AM - 9 AM (Early Bird)",
                  "9AM - 5 PM (Core Business Hours)",
                  "9PM - 2AM (Night Owl)",
                ],
                onSelectItem: (chosenItem) {},
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
                  label: kNext,
                  onPressed: () {
                    // TODO: - Notify Bloc
                    context.pushNamed(kAddKnowledgeBaseThreeRoute);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
