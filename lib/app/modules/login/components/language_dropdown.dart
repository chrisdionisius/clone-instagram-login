import 'package:flutter/material.dart';

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({super.key});

  @override
  LanguageDropdownState createState() => LanguageDropdownState();
}

class LanguageDropdownState extends State<LanguageDropdown> {
  String dropdownValue = 'English';
  final List<String> languages = ['English', 'Arabic', 'Italian', 'French'];
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      key: const Key('language_dropdown'),
      dropdownColor: Colors.white,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 10,
      style: const TextStyle(color: Colors.black54),
      underline: Container(),
      onChanged: (String? newValue) =>
          setState(() => dropdownValue = newValue!),
      items: languages.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          key: Key('language_dropdown_item_$value'),
          value: value,
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        );
      }).toList(),
    );
  }
}
