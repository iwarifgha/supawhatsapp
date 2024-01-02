import 'package:flutter/material.dart';

import '../text/app_text_medium.dart';
import '../text/app_text_small.dart';


class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key,
    required this.title,
    this.subtitle
  }) : super(key: key);

  final String title;
  final String? subtitle;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Icon(Icons.arrow_back),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextMedium(text: title),
          AppTextSmall(text: subtitle ?? '')
        ],
      ),
      actions: const [
        Icon(Icons.camera_alt_outlined,),
        SizedBox(width: 20,),
        Icon(Icons.search_outlined,),
        SizedBox(width: 18,),
        Icon(Icons.more_vert_outlined)
      ],
    );
  }
}
