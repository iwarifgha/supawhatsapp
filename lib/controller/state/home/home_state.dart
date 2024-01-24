import 'package:equatable/equatable.dart';
import '../../../model/chat/chat.dart';
import '../../../model/user/user.dart';


abstract class HomeCubitState extends Equatable {
  final bool? hasException;
  final bool? isLoading;
  final String? errorMessage;

  const HomeCubitState({
    this.hasException,
    this.isLoading,
    this.errorMessage,
  });
}


class HomeStateInitial extends HomeCubitState {
   const HomeStateInitial();

  @override
   List<Object?> get props => [];
}


class HomeContactsState extends HomeCubitState {
  final MyUser user;
  const HomeContactsState({
    required this.user,
    super.isLoading,
    super.errorMessage,
    super.hasException
});

  @override
  List<Object?> get props => [];
}


class HomeChatState extends HomeCubitState {
  final MyUser currentUser;
  final MyUser recipient;
  const HomeChatState({
    required this.currentUser,
    required this.recipient,
    super.isLoading,
    super.errorMessage,
    super.hasException
});

  @override
  List<Object?> get props => [];
}

class HomePageState extends HomeCubitState {
  final MyUser user;
  final List<Chat>? chats;

   const HomePageState({
     required this.user,
     this.chats,
     super.errorMessage,
     super.hasException,
     super.isLoading
   });

  @override
   List<Object?> get props =>  [chats,];
}
