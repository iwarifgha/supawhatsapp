
import '../../helpers/enums/calltype.dart';
import '../user/user.dart';

class Call {
  final MyUser caller;
  final CallType callType;
  final String timeOfCall;

  Call({required this.timeOfCall,  required this.caller, required this.callType});
}