import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.onTap,
    required this.text
  }) : super(key: key);

  final VoidCallback onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 80,
        decoration: BoxDecoration(
          color: Colors.greenAccent.shade700.withBlue(155).withAlpha(250),
          borderRadius: BorderRadius.circular(5)
        ),
        child: Center(
          child: Text( text,
            style: const TextStyle(
              fontSize: 16,
                color: Colors.black
            ),
          ),
        ),
      ),
    );
  }
}
