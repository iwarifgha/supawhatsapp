import 'package:flutter/material.dart';

 import '../../../model/call/call_model.dart';
import '../../enums/calltype.dart';
import '../text/app_text_medium.dart';
import '../text/app_text_small.dart';

class CallLogWidget extends StatelessWidget {
  const CallLogWidget({Key? key, required this.call}) : super(key: key);

  final Call call;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 10, bottom: 10),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(radius: 24, backgroundImage: AssetImage(call.caller.imageUrl!),),
          const SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextMedium(text: call.caller.name!),
              AppTextSmall(text: call.timeOfCall),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: call.callType == CallType.voiceCall  ?
              Icon(Icons.call, color: Colors.greenAccent.shade700.withBlue(155),)  :
              Icon(Icons.video_call_rounded, color: Colors.greenAccent.shade700.withBlue(155),),
            onPressed: () {  },),
        ],
      ),
    );
  }
}

