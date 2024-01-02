import 'package:equatable/equatable.dart';

import '../../../helpers/enums/active_status.dart';

abstract class StartUpState extends Equatable{
  const StartUpState();
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
  final String errorMessage;

  const StartUpErrorState({
    required this.errorMessage
  });

  @override
  List<Object?> get props => [errorMessage];
}

class StartUpHomeState extends StartUpState {
  final bool isLoading;
  final ActiveStatus status;

  const StartUpHomeState({required this.status, required this.isLoading});

  @override
  List<Object?> get props => [status, isLoading];

}