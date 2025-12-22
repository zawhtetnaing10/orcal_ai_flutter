import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:orcal_ai_flutter/utils/colors.dart';
import 'package:orcal_ai_flutter/utils/dimens.dart';
import 'package:orcal_ai_flutter/utils/widget_utils.dart';
import 'package:orcal_ai_flutter/widgets/orcal_search_field.dart';

class OrcalTimezonePicker extends StatefulWidget {
  final Function(String) onTimezonePicked;
  final String label;
  final String hint;

  const OrcalTimezonePicker({
    super.key,
    required this.onTimezonePicked,
    required this.label,
    required this.hint,
  });

  @override
  State<OrcalTimezonePicker> createState() => _OrcalTimezonePickerState();
}

class _OrcalTimezonePickerState extends State<OrcalTimezonePicker> {
  final TextEditingController _timezoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: kMarginCardMedium2,
      children: [
        Text(widget.label, style: TextStyle(color: Colors.white)),
        GestureDetector(
          onTap: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return Dialog(
                  backgroundColor: kBackgroundColor,
                  insetPadding: EdgeInsets.symmetric(horizontal: kMarginLarge),
                  child: TimezonePickerContent(
                    onSelectTimezone: (timezone) {
                      setState(() {
                        _timezoneController.text = timezone;
                      });
                      widget.onTimezonePicked(timezone);
                    },
                  ),
                );
              },
            );
          },
          child: Container(
            height: kTextFieldHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(kMarginCardMedium2),
            ),
            padding: EdgeInsets.symmetric(horizontal: kMarginMedium),
            child: Center(
              child: TextField(
                enabled: false,
                controller: _timezoneController,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: kTextRegular2X,
                ),
                decoration: InputDecoration(
                  hint: Text(
                    widget.hint,
                    style: TextStyle(
                      color: kHintColor,
                      fontSize: kTextRegular2X,
                    ),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TimezonePickerContent extends StatefulWidget {
  final Function(String) onSelectTimezone;

  const TimezonePickerContent({super.key, required this.onSelectTimezone});

  @override
  State<TimezonePickerContent> createState() => _TimezonePickerContentState();
}

class _TimezonePickerContentState extends State<TimezonePickerContent> {
  List<String> allTimezones = [];
  List<String> timezones = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState here
    super.initState();

    /// Get available time zones
    FlutterTimezone.getAvailableTimezones()
        .then((timezones) {
          setState(() {
            List<String> allTimezones = timezones
                .map((timezone) => timezone.identifier)
                .toList();
            this.allTimezones = allTimezones;
            this.timezones = allTimezones;
          });
        })
        .catchError((e) {
          if (mounted) {
            showErrorDialog(
              context: context,
              errorMessage: "Cannot fetch timezones $e",
              onTapOk: () {},
            );
          }
        });

    /// Listener for search
    _searchController.addListener(() {
      setState(() {
        if (_searchController.text.isNotEmpty) {
          List<String> filteredTimeZones = allTimezones
              .where(
                (timezone) => timezone.toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                ),
              )
              .toList();
          timezones = filteredTimeZones;
        } else {
          timezones = allTimezones;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: kMarginMedium2,
        vertical: kMarginMedium3,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OrcalSearchField(
            controller: _searchController,
            hint: "Search Timezone...",
          ),
          SizedBox(height: kMarginMedium),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView.builder(
              itemCount: timezones.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    widget.onSelectTimezone(timezones[index]);
                    Navigator.pop(context);
                  },
                  title: Text(
                    timezones[index],
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
