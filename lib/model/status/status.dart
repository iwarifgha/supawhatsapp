import 'package:whatsapp_clone/helpers/enums/content_type.dart';
import 'package:whatsapp_clone/model/status/text_status.dart';
import 'package:whatsapp_clone/model/user/user.dart';


class Status{
  final String? imageContent;
  final TextStatus? textStatus;
  final MyUser statusOwner;
  final String timePosted;
  int viewCount;
  final ContentType statusType;


  Status({
    required this.statusType,
    this.imageContent,
    this.textStatus,
    required this.statusOwner,
    required this.timePosted,
    this.viewCount = 0
  });

}