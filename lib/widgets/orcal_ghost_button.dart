import 'package:flutter/material.dart';
import 'package:orcal_ai_flutter/utils/colors.dart';

import '../utils/dimens.dart';

class OrcalGhostButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const OrcalGhostButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kMarginCardMedium2),
          side: BorderSide(width: 1.0, color: kPrimaryColor),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: kTextRegular2X,
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
