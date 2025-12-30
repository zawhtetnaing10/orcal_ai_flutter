import 'package:flutter/material.dart';
import 'package:orcal_ai_flutter/utils/colors.dart';
import 'package:orcal_ai_flutter/utils/dimens.dart';

class OrcalTextFieldExternalText extends StatelessWidget {
  const OrcalTextFieldExternalText({
    super.key,
    required this.hint,
    required this.controller,
    required this.isEnabled,
    this.innerPadding,
  });

  final String hint;
  final TextEditingController controller;
  final bool isEnabled;
  final EdgeInsets? innerPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kTextFieldHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kMarginCardMedium2),
      ),
      padding: EdgeInsets.symmetric(horizontal: kMarginMedium),
      child: Center(
        child: Padding(
          padding: innerPadding ?? EdgeInsets.zero,
          child: TextField(
            enabled: isEnabled,
            controller: controller,
            decoration: InputDecoration(
              hint: Text(
                hint,
                style: TextStyle(color: kHintColor, fontSize: kTextRegular2X),
              ),
              border: InputBorder.none,
            ),
            style: TextStyle(color: Colors.black, fontSize: kTextRegular2X),
          ),
        ),
      ),
    );
  }
}
