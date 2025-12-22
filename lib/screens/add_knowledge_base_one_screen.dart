import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orcal_ai_flutter/utils/colors.dart';
import 'package:orcal_ai_flutter/utils/dimens.dart';
import 'package:orcal_ai_flutter/utils/routes.dart';
import 'package:orcal_ai_flutter/utils/strings.dart';
import 'package:orcal_ai_flutter/widgets/orcal_primary_button.dart';
import 'package:orcal_ai_flutter/widgets/orcal_text_area.dart'
    show OrcalTextArea;
import 'package:orcal_ai_flutter/widgets/orcal_textfield_with_label.dart';
import 'package:orcal_ai_flutter/widgets/orcal_timezone_picker.dart';

class AddKnowledgeBaseOneScreen extends StatelessWidget {
  const AddKnowledgeBaseOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  onTextChanged: (input) {},
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: kMarginMedium3),
                child: OrcalTextArea(
                  label:
                      "How do you describe your professional role or \"vibe\" in one sentence?",
                  hint: "Your professional role...",
                  onChanged: (input) {},
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: kMarginMedium3),
                child: OrcalTimezonePicker(
                  label:
                      "Where are you based, and what is your current timezone?",
                  hint: "Timezone...",
                  onTimezonePicked: (timezone) {},
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: kMarginXLarge),
                child: SizedBox(
                  width: double.infinity,
                  height: kMarginXXLarge,
                  child: OrcalPrimaryButton(label: kNext, onPressed: () {
                    // TODO: - Notify Bloc
                    context.pushNamed(kAddKnowledgeBaseTwoRoute);
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
