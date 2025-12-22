import 'package:flutter/material.dart';
import 'package:orcal_ai_flutter/utils/colors.dart';
import 'package:orcal_ai_flutter/utils/dimens.dart';

class OrcalTextFieldWithLabel extends StatelessWidget {
  final String label;
  final String hint;
  final Function(String) onTextChanged;

  const OrcalTextFieldWithLabel({
    super.key,
    required this.label,
    required this.hint,
    required this.onTextChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: kMarginCardMedium2,
      children: [
        Text(label, style: TextStyle(color: Colors.white)),
        Container(
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
              onChanged: onTextChanged,
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
        ),
      ],
    );
  }
}
