import 'package:flutter/material.dart';

class InputMessageWidget extends StatelessWidget {
    InputMessageWidget({Key? key,
    required this.textController,
    this.prefixIcon,
    required this.isTypingNotifier,
    this.firstSuffixIcon,
    this.secondSuffixIcon,
    required this.onSend,
      required this.onRecord
  }) : super(key: key);

  final TextEditingController textController;
  final IconData? prefixIcon;
  final IconData? firstSuffixIcon;
  final IconData? secondSuffixIcon;
  final VoidCallback onSend;
  final VoidCallback onRecord;
  ValueNotifier<bool> isTypingNotifier;

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 60,
      color: Colors.black45,
      child:  Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Text Box
            Expanded(
              child: Material(
                borderRadius: BorderRadius.circular(25),
                color: Colors.blueGrey.shade500.withAlpha(50),
                child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                        labelText: 'Message',
                        //hintText: 'Message',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        prefixIcon: Icon(prefixIcon, color: Colors.grey.withOpacity(0.8),),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(firstSuffixIcon, color: Colors.grey.withOpacity(0.8),),
                              const SizedBox(width: 15,),
                              Icon(secondSuffixIcon, color: Colors.grey.withOpacity(0.8),)
                            ],
                          ),
                        )
                    )
                ),
              ),
            ),
            const SizedBox(width: 10,),
            //Voice Note Button
            ValueListenableBuilder(
              valueListenable: isTypingNotifier ,
              builder:(_, value, __){
                   return Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.greenAccent.shade700.withBlue(155).withAlpha(250),
                          shape: BoxShape.circle
                ),
                      child: IconButton(
                          onPressed: ( ){
                            value ? onRecord() : onSend();
                          },
                          icon: Icon(value ? Icons.mic : Icons.send),
                      )
                  );

              }
            )
          ],
        ),
      ),
    );
  }
}

