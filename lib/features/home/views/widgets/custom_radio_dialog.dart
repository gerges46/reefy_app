import 'package:flutter/material.dart';

class CustomRadioDialog extends StatelessWidget {
  final String title;
  final List<String> options;
  final String? selectedValue;
  final Function(String value) onChanged;

  const CustomRadioDialog({
    super.key,
    required this.title,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: options
              .map(
                (option) => RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: selectedValue,
                  onChanged: (value) {
                    onChanged(value!);
                    Navigator.of(context).pop();
                  },
                ),
              )
              .toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("تاكيد", style: TextStyle(color: Colors.green)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("إلغاء", style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }
}
