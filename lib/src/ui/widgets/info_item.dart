import 'package:flutter/material.dart';

import '../../config/app_colors.dart';

class InfoItem extends StatelessWidget {
  final String boldText;
  final String normalText;

  const InfoItem({
    super.key,
    required this.boldText,
    required this.normalText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          boldText,
          style:  TextStyle(
            decoration: TextDecoration.none,
            fontSize: 16.0,
            fontWeight: FontWeight.w900,
            color: AppColors().primaryColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            normalText,
            style:  const TextStyle(
              decoration: TextDecoration.none,
              fontSize: 14.0,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
