import 'package:flutter/material.dart';

class CallLogList extends StatelessWidget {
  const CallLogList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount:  0,
          itemBuilder: (context, index){
            return Container();
            /*CallLogWidget(call: mockCallLogs[index]);*/
          }),
    );
  }
}