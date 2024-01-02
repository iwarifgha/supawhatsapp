import 'package:flutter/material.dart';

class QuickActionTile extends StatelessWidget {
  const QuickActionTile({super.key, required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor:  Colors.greenAccent.shade700.withBlue(155).withAlpha(250),),
        title:   Text(title),
      ),
    );
  }
}
