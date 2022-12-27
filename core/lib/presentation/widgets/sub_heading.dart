import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class SubHeading extends StatelessWidget {
  const SubHeading({
    required this.title,
    required this.onTap,
    required this.buttonKey,
  });

  final String title;
  final Function() onTap;
  final String buttonKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading5,
        ),
        InkWell(
          key: Key(buttonKey),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}
