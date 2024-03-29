import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future showErrorDialog (BuildContext context, String text){
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(text),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  },
                child: const Text('Ok'))
          ],
        );
      }
  );
}