import 'package:flutter/material.dart';
import 'package:orcal_ai_flutter/utils/dimens.dart';

import '../utils/colors.dart';

class OrcalSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const OrcalSearchField({
    super.key,
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kTextFieldHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          kMarginCardMedium2,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: kMarginMedium,
      ),
      child: Center(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hint: Text(
              hint,
              style: TextStyle(
                color: kHintColor,
                fontSize: kTextRegular2X,
              ),
            ),
            border: InputBorder.none,
          ),
          style: TextStyle(
            color: Colors.black,
            fontSize: kTextRegular2X,
          ),
        ),
      ),
    );
  }
}
