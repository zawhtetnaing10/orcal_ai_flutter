import 'package:flutter/material.dart';
import 'package:orcal_ai_flutter/utils/colors.dart';
import 'package:orcal_ai_flutter/utils/dimens.dart';
import 'package:orcal_ai_flutter/utils/images.dart';
import 'package:orcal_ai_flutter/widgets/orcal_ghost_button.dart';
import 'package:orcal_ai_flutter/widgets/orcal_primary_button.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onTapOk;

  const LogoutDialog({super.key, required this.onTapOk});

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
              Images.kLogoutLogo,
              color: Colors.red,
              width: kDialogLogoSize,
              height: kDialogLogoSize,
            ),
            Padding(
              padding: EdgeInsets.only(top: kMarginMedium2),
              child: Text(
                "Are you sure?",
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
                child: Row(
                  spacing: kMarginCardMedium2,
                  children: [
                    Expanded(
                      child: OrcalGhostButton(
                        label: "Cancel",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Expanded(
                      child: OrcalPrimaryButton(
                        label: "OK",
                        onPressed: () {
                          Navigator.pop(context);
                          onTapOk();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
