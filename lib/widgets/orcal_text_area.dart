import 'package:flutter/material.dart';
import 'package:orcal_ai_flutter/utils/colors.dart';
import 'package:orcal_ai_flutter/utils/dimens.dart';

class OrcalTextArea extends StatelessWidget {
  final String label;
  final String hint;
  final Function(String) onChanged;

  const OrcalTextArea({
    required this.label,
    required this.hint,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: kMarginCardMedium2,
      children: [
        Text(label, style: TextStyle(color: Colors.white)),
        Container(
          height: kTextAreaHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(kMarginCardMedium2),
          ),
          padding: EdgeInsets.symmetric(horizontal: kMarginMedium),
          child: TextField(
            maxLines: null,
            onChanged: onChanged,
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
      ],
    );
  }
}