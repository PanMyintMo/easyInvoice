import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class ThemeHelperUserRole {
  InputDecoration textInputDecoration([
    String lableText = "",
    String hintText = "",
    IconData? iconData,
  ]) {
    return InputDecoration(
      labelText: lableText,
      hintText: hintText,
      prefixIcon: iconData != null
          ? Padding(
              padding: const EdgeInsets.only(left: 20, right: 30),
              // Adjust the left and right padding values
              child: Icon(iconData),
            )
          : null,
      prefixIconConstraints: BoxConstraints(minWidth: 50),
      // Set minimum width for the prefix icon
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),

      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: BorderSide(color: Colors.grey)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.grey.shade400)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0)),
    );
  }

  BoxDecoration inputBoxDecorationShaddow() {
    return BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 10,
        offset: const Offset(0, 5),
      )
    ]);
  }

  ButtonStyle buttonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      minimumSize: MaterialStateProperty.all(Size(50, 50)),
      backgroundColor: MaterialStateProperty.all(Colors.blue),
      shadowColor: MaterialStateProperty.all(Colors.blue.shade900),
    );
  }
}

Widget buildInputContainer(String labelText, String hintText, IconData iconData,
    dynamic controller, dynamic validator, dynamic keyboardType) {
  return Container(
    decoration: ThemeHelperUserRole().inputBoxDecorationShaddow(),
    child: TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      decoration: ThemeHelperUserRole().textInputDecoration(
        labelText,
        hintText,
        iconData,
      ),
      validator: validator,
    ),
  );
}

Widget buildProductContainerText(String name) {
  return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: Text(
        name,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Color(0xff000000),
        ),
      ));
}

Widget buildProductContainerForm(String label, TextInputType inputType,
    TextEditingController controller, String? Function(String?)? validator) {
  return TextFormField(
    keyboardType: inputType,
    controller: controller,
    validator: validator,
    decoration: InputDecoration(
      hintText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue, width: 1.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      fillColor: Colors.grey,
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // Adjust these values as needed

    ),
  );
}

Widget buildProfileBox(String name, String realName) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.centerLeft,
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent.shade400, width: 0.3),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Text(realName),
          )
        ],
      ),
    ),
  );
}



Widget textFieldForm(dynamic controller, String label) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      labelText: label,
    ),
  );
}


Widget buildDropdown({
  required  value,
  required Function(dynamic) onChanged,
  String? hint,
  required items,
  required BuildContext context,
}) {

  return DropdownButtonFormField2(
    value: value,
    isDense: true,
    hint: Text(hint.toString()),
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    items: items,
    onChanged: onChanged,
    buttonStyleData: const ButtonStyleData(
      padding: EdgeInsets.only(right: 10),
    ),
    iconStyleData:  IconStyleData(
      icon: Icon(
        Icons.arrow_drop_down,
        color:  AdaptiveTheme.of(context).theme.iconTheme.color,
      ),
      iconSize: 24,
    ),
    dropdownStyleData: DropdownStyleData(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    menuItemStyleData: const MenuItemStyleData(
      padding: EdgeInsets.symmetric(horizontal: 16),
    ),
  );
}
