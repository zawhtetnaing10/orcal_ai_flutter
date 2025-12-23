import 'package:flutter/material.dart';
import 'package:orcal_ai_flutter/utils/colors.dart';
import 'package:orcal_ai_flutter/utils/dimens.dart';
import 'package:orcal_ai_flutter/utils/images.dart';
import 'package:orcal_ai_flutter/widgets/orcal_primary_button.dart';

class BuildEmbeddingsSuccessDialog extends StatelessWidget {
  final VoidCallback onTapOk;

  const BuildEmbeddingsSuccessDialog({super.key, required this.onTapOk});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(kMarginLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              Images.kAppLogo,
              width: kDialogLogoSize,
              height: kDialogLogoSize,
            ),
            Padding(
              padding: EdgeInsets.only(top: kMarginMedium2),
              child: Text(
                "Successfully built your knowledge base!!!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: kTextRegular,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: kMarginMedium2),
              child: SizedBox(
                width: double.infinity,
                child: OrcalPrimaryButton(
                  label: "Go to Home",
                  onPressed: () {
                    Navigator.pop(context);
                    onTapOk();
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
