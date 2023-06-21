import 'package:flutter/material.dart';

class ThemeHelperUserRole {
  InputDecoration textInputDecoration([  String lableText = "",
    String hintText = "",   IconData? iconData,]) {
    return InputDecoration(
      labelText: lableText,
      hintText: hintText,
        prefixIcon: iconData != null ? Padding(
          padding: const EdgeInsets.only(left: 20, right: 30), // Adjust the left and right padding values
          child: Icon(iconData),
        ) : null,
      prefixIconConstraints: BoxConstraints(minWidth: 50), // Set minimum width for the prefix icon
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
      backgroundColor: MaterialStateProperty.all(Colors.redAccent),
      shadowColor: MaterialStateProperty.all(Colors.red),
    );
  }
}


Widget buildInputContainer(String labelText, String hintText, IconData iconData,dynamic controller,dynamic validator,dynamic keyboardType) {
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

Widget buildProfileBox(String name,String realName) {
  return Expanded(
   child: Padding(
     padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 10.0),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         Text(name),
         Container(
           width: 200,
           decoration: BoxDecoration(
             border: Border.all(color: Colors.black12, width: 0.5),
             borderRadius: BorderRadius.all(Radius.circular(50.0)),
           ),
           child: Center(child: Text(realName)),
         )
       ],
     ),
   ),
  );
}




