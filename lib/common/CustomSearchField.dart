import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController textController;
  final Function onSuffixTap;
  final Function onSubmitted;

  CustomSearchBar({required this.textController, required this.onSuffixTap, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return AnimSearchBar(
      width: 300,
      rtl: true,

      color: Colors.redAccent,
      closeSearchOnSuffixTap: true,
      helpText: 'Date here....',
      animationDurationInMilli: 2000,
      textController: textController,
      onSuffixTap: onSuffixTap,
      onSubmitted: onSubmitted(),
    );
  }
}