import 'package:flutter/material.dart';
import 'package:orcal_ai_flutter/utils/dimens.dart';

import '../utils/colors.dart';

class OrcalPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const OrcalPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kMarginCardMedium2),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: kTextRegular2X),
      ),
    );
  }
}
