import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orcal_ai_flutter/utils/colors.dart';
import 'package:orcal_ai_flutter/utils/dimens.dart';
import 'package:orcal_ai_flutter/utils/strings.dart';
import 'package:orcal_ai_flutter/widgets/orcal_primary_button.dart';
import 'package:orcal_ai_flutter/widgets/orcal_text_area.dart' show OrcalTextArea;

class AddKnowledgeBaseThreeScreen extends StatelessWidget {
  const AddKnowledgeBaseThreeScreen({super.key});

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
                label: "What topics are you currently obsessed with or learning?",
                hint: "Topics currently learning...",
                onChanged: (input) {},
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                top: kMarginMedium3,
                left: kMarginMedium2,
                right: kMarginMedium2,
              ),
              child: OrcalTextArea(
                label: "What are your work boundaries? (Things you want to avoid)",
                hint: "Things to avoid...",
                onChanged: (input) {},
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
                    // TODO: - Notify Bloc
                    print("Call build knowledge base endpoint");
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
