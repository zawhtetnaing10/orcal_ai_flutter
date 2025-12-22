import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:orcal_ai_flutter/utils/dimens.dart';
import 'package:orcal_ai_flutter/widgets/orcal_textfield_with_label.dart';

class OrcalMultipleTextFields extends StatelessWidget {
  final String label;
  final int count;
  final String hint;

  final Map<int, String> inputs = HashMap();
  final Function(Map<int, String>) onInputChanged;

  OrcalMultipleTextFields({
    super.key,
    required this.label,
    required this.count,
    required this.hint,
    required this.onInputChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: kMarginCardMedium2,
      children: [
        Text(label, style: TextStyle(color: Colors.white)),

        Column(
          spacing: kMarginCardMedium2,
          children: List.generate(count, (index) => index + 1).map((index) {
            return Row(
              spacing: kMarginCardMedium2,
              children: [
                Text(
                  "$index. ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: OrcalTextField(
                    onTextChanged: (text) {
                      inputs[index] = text;
                      onInputChanged(inputs);
                    },
                    hint: hint,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
