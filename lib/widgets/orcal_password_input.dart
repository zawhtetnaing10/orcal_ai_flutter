import 'package:flutter/material.dart';
import 'package:orcal_ai_flutter/utils/colors.dart';
import 'package:orcal_ai_flutter/utils/dimens.dart';

class OrcalPasswordInput extends StatefulWidget {
  final String label;
  final String hint;
  final Function(String) onTextChanged;

  const OrcalPasswordInput({
    super.key,
    required this.label,
    required this.hint,
    required this.onTextChanged,
  });

  @override
  State<OrcalPasswordInput> createState() => _OrcalPasswordInputState();
}

class _OrcalPasswordInputState extends State<OrcalPasswordInput> {
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: kMarginMedium,
      children: [
        Text(widget.label, style: TextStyle(color: Colors.white)),
        Container(
          height: kTextFieldHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(kMarginCardMedium2),
          ),
          padding: EdgeInsets.symmetric(horizontal: kMarginMedium),
          child: Center(
            child: TextField(
              obscureText: isPasswordHidden,
              onChanged: widget.onTextChanged,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordHidden = !isPasswordHidden;
                    });
                  },
                  color: kHintColor,
                ),
                hint: Text(
                  widget.hint,
                  style: TextStyle(color: kHintColor, fontSize: kTextRegular2X),
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(color: Colors.black, fontSize: kTextRegular2X),
            ),
          ),
        ),
      ],
    );
  }
}
