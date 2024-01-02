import 'package:flutter/material.dart';

class StatusList extends StatelessWidget {
  const StatusList({Key? key,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 0,
          itemBuilder: (context, index){
            return  Container();
            /*Padding(
               padding: const EdgeInsets.symmetric(vertical: 5.0),
               child: StatusWidget(status: contactStatus[index],),
             );*/
          }),
    );
  }
}