import 'package:flutter/material.dart';

class AppTextSmall extends StatelessWidget {
  const AppTextSmall({Key? key, required this.text}) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      style: const TextStyle(
        fontSize: 12,
        color: Colors.grey,
       ),
    );
  }
}
