import 'dart:io';

import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';



@immutable
abstract class AuthCubitState extends Equatable{
  const AuthCubitState();
}

class AuthStateInitial extends AuthCubitState {
  const AuthStateInitial();
  @override
  List<Object?> get props => [];
}


class AuthStateDone extends AuthCubitState {
  const AuthStateDone();
  @override
  List<Object?> get props => [];
}


class AuthStateSetProfile extends AuthCubitState {
  final bool? isLoading;
  final bool? hasError;
  final String? errorMessage;
  final File? file;
  final String phone;

  const AuthStateSetProfile({
    required this.phone,
    this.file,
    this.errorMessage,
    this.isLoading,
    this.hasError,
    });

  @override
  // TODO: implement props
  List<Object?> get props => [isLoading, hasError, phone, errorMessage, file];

}

class AuthStateTakePicture extends AuthCubitState {
  final CameraDescription camera;
  final CameraController controller;
  final bool? isLoading;
  final String phone;
  final bool? hasError;
  final String? errorMessage;
  final File? file;



  const AuthStateTakePicture({
    required this.camera,
    required this.controller,
    this.errorMessage,
    this.isLoading,
    this.hasError,
    this.file,
    required this.phone,
   });

  @override
  List<Object?> get props => [camera, controller, errorMessage, isLoading, hasError];
}

class AuthStateSignOut extends AuthCubitState {
  const AuthStateSignOut();
  @override
  List<Object?> get props => [];
}


class AuthStateVerifyOtp extends AuthCubitState {
  final bool? hasError;
  final String? errorMessage;
  final String phone;
  final bool isLoading;

  const AuthStateVerifyOtp({
    this.hasError,
    this.errorMessage,
    required this.phone,
    this.isLoading = false
  });
  @override
  List<Object?> get props => [phone, hasError, errorMessage, isLoading];
}


class AuthStateSignIn extends AuthCubitState {
  final bool? hasError;
  final String? errorMessage;
  final bool isLoading;

  const AuthStateSignIn({
     this.isLoading = false,
     this.hasError,
     this.errorMessage,
   });
  @override
  List<Object?> get props => [hasError, errorMessage, isLoading];
}

/*AuthStateVerifyOtp copyWith({
  bool? hasError,
  String? errorMessage,
  bool? isLoading
}){
  return AuthStateVerifyOtp(
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      phone: phone,
      isLoading: isLoading ?? this.isLoading
  );
}*/