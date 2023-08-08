import 'package:flutter/material.dart';

class CustomDropdownButton2 extends StatefulWidget {
  final String hint;
  final Color? iconEnabledColor;
  final double iconSize;
  final String? value;
  final List<String> dropdownItems;
  final void Function(String?) onChanged;
  final BoxDecoration? buttonDecoration;

  CustomDropdownButton2({
    required this.hint,
    required this.iconEnabledColor,
    required this.iconSize,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.buttonDecoration,
  });

  @override
  _CustomDropdownButton2State createState() => _CustomDropdownButton2State();
}

class _CustomDropdownButton2State extends State<CustomDropdownButton2> {
  String? selectedValue;

  var buttonDecoration;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buttonDecoration ??
          BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
            value: selectedValue,
            icon: Icon(
              Icons.arrow_drop_down,
              color: widget.iconEnabledColor,
              size: widget.iconSize,
            ),
            onChanged: (value) {
              setState(() {
                selectedValue = value;
                widget.onChanged(value);
              });
            },
            items: widget.dropdownItems.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            hint: Center(
              child: Text(selectedValue ?? widget.hint),
            ) // Display the selected value or default hint
            ),
      ),
    );
  }
}
