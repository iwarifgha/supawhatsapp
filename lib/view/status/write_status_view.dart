import 'dart:math';

import 'package:flutter/material.dart';

import '../../helpers/widgets/message/input_message_widget.dart';

class WriteStatusView extends StatefulWidget {
    const WriteStatusView({Key? key}) : super(key: key);

  @override
  State<WriteStatusView> createState() => _WriteStatusViewState();
}

class _WriteStatusViewState extends State<WriteStatusView> {
  final TextEditingController textController = TextEditingController();
  Color containerColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: containerColor,
            child: Center(
              child: TextField(
                textAlign: TextAlign.center,
                controller: textController,
                focusNode: FocusNode(),
                style: const TextStyle(
                  fontSize: 24
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back_ios_new)),
                const Spacer(),
                ///Emoji picker
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.emoji_emotions, color: Colors.white)),
                ///Font chooser
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.text_fields, color: Colors.white)),

                ///Color palette
                IconButton(
                    onPressed: () {
                      setState(() {
                        containerColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
                      });
                    },
                    icon: const Icon(Icons.palette, color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
      bottomSheet:  Container(),
    );
  }
}
