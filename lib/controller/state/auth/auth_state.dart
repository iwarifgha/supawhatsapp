import 'dart:io';

import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../model/user/user.dart';



@immutable
abstract class AuthCubitState extends Equatable{
  final bool? hasException;
  final bool? isLoading;
  final String? errorMessage;
  const AuthCubitState({
    this.hasException,
    this.isLoading,
    this.errorMessage,
  });
}

class AuthStateInitial extends AuthCubitState {
  const AuthStateInitial();
  @override
  List<Object?> get props => [];
}


class AuthStateComplete extends AuthCubitState {
  final MyUser user;

  const AuthStateComplete({
    required this.user
  });
  @override
  List<Object?> get props => [];
}


class AuthStateSetProfile extends AuthCubitState {

  final File? file;
  final String phone;

  const AuthStateSetProfile({
    required this.phone,
    this.file,
    super.errorMessage,
    super.isLoading,
    super.hasException,
    });

  @override
  // TODO: implement props
  List<Object?> get props => [isLoading, hasException, phone, errorMessage, file];

}

class AuthStateTakePicture extends AuthCubitState {
  final CameraDescription camera;
  final CameraController controller;
  final String phone;
  final File? file;



  const AuthStateTakePicture({
    required this.camera,
    required this.controller,
    this.file,
    required this.phone,
    super.errorMessage,
    super.isLoading,
    super.hasException,

   });

  @override
  List<Object?> get props => [camera, controller, errorMessage, isLoading, hasException];
}

class AuthStateSignOut extends AuthCubitState {
  const AuthStateSignOut();
  @override
  List<Object?> get props => [];
}


class AuthStateVerifyOtp extends AuthCubitState {

  final String phone;

  const AuthStateVerifyOtp({
    required this.phone,
    super.hasException,
    super.errorMessage,
    super.isLoading
  });
  @override
  List<Object?> get props => [phone, hasException, errorMessage, isLoading];
}


class AuthStateSignIn extends AuthCubitState {

  const AuthStateSignIn({
    super.isLoading,
    super.hasException,
    super.errorMessage,
   });
  @override
  List<Object?> get props => [hasException, errorMessage, isLoading];
}

