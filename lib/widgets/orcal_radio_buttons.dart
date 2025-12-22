import 'package:flutter/material.dart';
import 'package:orcal_ai_flutter/utils/colors.dart';

import '../utils/dimens.dart';

class OrcalRadioButtons extends StatefulWidget {
  final String label;
  final List<String> items;
  final double innerPadding;
  final Function(String) onSelectItem;

  const OrcalRadioButtons({
    super.key,
    required this.label,
    required this.items,
    required this.innerPadding,
    required this.onSelectItem,
  });

  @override
  State<OrcalRadioButtons> createState() => _OrcalRadioButtonsState();
}

class _OrcalRadioButtonsState extends State<OrcalRadioButtons> {
  String chosenItem = "";

  @override
  void initState() {
    super.initState();
    chosenItem = widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: kMarginCardMedium2,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.innerPadding),
          child: Text(widget.label, style: TextStyle(color: Colors.white)),
        ),

        RadioGroup<String>(
          groupValue: chosenItem,
          onChanged: (chosenItem) {
            setState(() {
              if (chosenItem != null) {
                this.chosenItem = chosenItem;
                widget.onSelectItem(chosenItem);
              }
            });
          },
          child: Column(
            children: widget.items
                .map(
                  (item) => RadioListTile(
                    value: item,
                    contentPadding: EdgeInsets.zero,
                    activeColor: kPrimaryColor,
                    title: Text(
                      item,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
