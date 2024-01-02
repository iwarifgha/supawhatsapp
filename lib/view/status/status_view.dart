import 'package:flutter/material.dart';

import '../../model/status/status.dart';


class MediaStatusView extends StatelessWidget {
  const MediaStatusView({Key? key, required this.status}) : super(key: key);
  final Status status;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return  Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                  image: AssetImage(status.imageContent!))
            ),
          ),
          //top bar
          Positioned(
            top: screenHeight * 0.05,
            left: 0,
            right: 0,
            child: TopBarSection(
                timePosted: status.timePosted,
                imageString: status.statusOwner.imageUrl!,
                phoneNumber: status.statusOwner.phoneNumber,
              name: status.statusOwner.name,
            ) ,
          ),
          //bottom bar
            Positioned(
              top: screenHeight * 0.90,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  const Center(
                      child: Icon(Icons.remove_red_eye_outlined)),
                  Text(status.viewCount.toString())
                ],
              )
          )
        ],
      ),
    );
  }
}


class TopBarSection extends StatelessWidget {
  const TopBarSection({Key? key, this.name, required this.timePosted, required this.imageString, required this.phoneNumber}) : super(key: key);

  final String? name;
  final String timePosted;
  final String imageString;
  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        ///the back button
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios_new)),
        ///the profile picture
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(imageString))
          ),
        ),
        ///the user name and time posted
        const SizedBox(width: 10,),
        Column(
          children: [
             Text(name ?? phoneNumber,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(timePosted),
          ],
        ),
        ///space
        const Spacer(),
        ///the more-options button
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_outlined, color: Colors.white)),
      ],
    );
  }
}

