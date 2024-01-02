import 'package:flutter/material.dart';

class AppTextChat extends StatelessWidget {
  const AppTextChat({Key? key, required this.text}) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
      maxLines: null,
      overflow: TextOverflow.clip,
      softWrap: true,
      style: const TextStyle(
        color: Colors.white,
      ),
    );
  }
}
