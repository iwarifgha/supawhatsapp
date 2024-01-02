import 'package:flutter/material.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({super.key, 
    required this.imageUrl, 
    required this.displayName, required this.onTap,
    //this.about
  });
  
  final String? imageUrl;
  final String displayName;
  final VoidCallback onTap;
  //final String? about;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        onTap();
      },
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: AssetImage(
          imageUrl!,
         ),
      ),
      title: Text(displayName),
      //subtitle: Text(about!),
    );
  }
}
