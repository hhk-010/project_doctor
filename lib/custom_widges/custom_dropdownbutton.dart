import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';

class CustomDropDownButton extends StatelessWidget {
  final String value;
  final String hint;
  final Function(String) onChanged;
  final List<DropdownMenuItem<String>> items;
  const CustomDropDownButton({
    Key key,
    this.value,
    this.hint,
    this.onChanged,
    this.items,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getDeviceType(context, 42, 50, 63, 60),
      decoration: CStyle.box,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 0,
            horizontal: getDeviceType(context, 15, 20, 25, 30),
          ),
          child: DropdownButton<String>(
            value: value,
            isDense: false,
            isExpanded: true,
            underline: SizedBox(),
            icon: Icon(Icons.keyboard_arrow_down),
            iconSize: getDeviceType(context, 30, 35, 40, 45),
            hint: Text(hint, style: CStyle.getSubtitle(context)),
            onChanged: onChanged,
            items: items,
          ),
        ),
      ),
    );
  }
}
