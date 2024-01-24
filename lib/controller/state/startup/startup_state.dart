import 'package:equatable/equatable.dart';


import '../../../model/user/user.dart';

abstract class StartUpState extends Equatable{
  final bool? hasException;
  final bool? isLoading;
  final String? errorMessage;

  const StartUpState({
    this.hasException,
    this.isLoading,
    this.errorMessage
});
}

class StartUpAuthState extends StartUpState{
  @override
  List<Object?> get props => [];
}

class StartUpInitialState extends StartUpState{
  @override
  List<Object?> get props => [];
}

class StartUpErrorState extends StartUpState{

  const StartUpErrorState({
    super.errorMessage
  });

  @override
  List<Object?> get props => [errorMessage];
}

class StartUpHomeState extends StartUpState {
  final MyUser user;

  const StartUpHomeState({
    required this.user,
    super.isLoading,
    super.errorMessage,
    super.hasException
  });

  @override
  List<Object?> get props => [user, isLoading, errorMessage, hasException];

}