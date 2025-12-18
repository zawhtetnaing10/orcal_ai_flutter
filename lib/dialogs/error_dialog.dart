import 'package:flutter/material.dart';
import 'package:orcal_ai_flutter/utils/colors.dart';
import 'package:orcal_ai_flutter/utils/dimens.dart';
import 'package:orcal_ai_flutter/utils/images.dart';
import 'package:orcal_ai_flutter/widgets/orcal_primary_button.dart';

class ErrorDialog extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onTapOk;

  const ErrorDialog({
    super.key,
    required this.errorMessage,
    required this.onTapOk,
  });

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
            Icon(
              Icons.warning_amber_outlined,
              color: Colors.red,
              size: kDialogLogoSize,
            ),
            Padding(
              padding: EdgeInsets.only(top: kMarginMedium2),
              child: Text(
                errorMessage,
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
                child: OrcalPrimaryButton(label: "OK", onPressed: (){
                  Navigator.pop(context);
                  onTapOk();
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
