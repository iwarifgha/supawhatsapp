import 'package:flutter/material.dart';
import 'package:whatsapp_clone/helpers/enums/content_type.dart';

 import '../../../model/status/status.dart';
import '../../../view/status/status_view.dart';
import '../text/app_text_medium.dart';
import '../text/app_text_small.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({Key? key, required this.status}) : super(key: key);

  final Status status;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MediaStatusView(
                  status: status,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 10, bottom: 10),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            status.statusType == ContentType.text
                ? CircleAvatar(
                    radius: 24,
                    backgroundColor: status.textStatus?.color,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SizedBox(
                          width: 100,
                          child: Text(status.textStatus!.text),
                        ),
                      ),
                    ),
                  )
                : CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage(status.imageContent!),
                  ),
            const SizedBox(
              width: 20,
            ),
            Column(
              children: [
                AppTextMedium(text: status.statusOwner.name!),
                AppTextSmall(text: status.timePosted),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.more_vert_outlined),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

/*
* ListTile(
      leading:
      title:
      subtitle:
      trailing:
      horizontalTitleGap: 15,
    );*/