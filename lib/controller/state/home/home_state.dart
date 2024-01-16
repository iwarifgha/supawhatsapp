import 'package:equatable/equatable.dart';
import '../../../model/chat/chat.dart';


abstract class HomeCubitState extends Equatable {
  const HomeCubitState();
}


class HomeStateInitial extends HomeCubitState {
   const HomeStateInitial();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class HomeStateStatus extends HomeCubitState {
  const HomeStateStatus();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class HomeContactsState extends HomeCubitState {
  const HomeContactsState();

  @override
  List<Object?> get props => [];
}



class HomeChatState extends HomeCubitState {
  final Chat chat;
  const HomeChatState({
    required this.chat,

  });

  @override
  // TODO: implement props
  List<Object?> get props => [chat];

}

class HomePageState extends HomeCubitState {
 // final ActiveStatus status;
  final List<Chat>? chats;
  //final bool? hasConnection;
  const HomePageState({
    //required this.status,
    this.chats,
    //this.hasConnection
  });

  @override
  // TODO: implement props
  List<Object?> get props =>  [chats,];
}
