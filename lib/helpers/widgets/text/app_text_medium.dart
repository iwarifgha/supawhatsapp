import 'package:flutter/material.dart';

class AppTextMedium extends StatelessWidget {
  const AppTextMedium({Key? key, required this.text}) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 17,
        fontWeight: FontWeight.w500
      ),
    );
  }
}