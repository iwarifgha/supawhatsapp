
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:whatsapp_clone/helpers/utils/camera_repo.dart';
import 'package:whatsapp_clone/helpers/utils/file_picker.dart';
import '../../../helpers/utils/locator.dart';
import '../../features/auth/auth_service.dart';
import '../../features/user/user_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {

  ///The AuthCubit begins the authentication flow.
  AuthCubit() : super(const AuthStateInitial()){
    startAuthFlow();
  }

  final  userProvider =  locator<UserService>();
  final  authProvider =  locator<AuthService>();
  final filePicker = MyFilePicker();
  final cameraProvider = CameraRepo();
  AuthCubitState lastState = const AuthStateInitial();




  @override
  void onChange(Change<AuthCubitState> change) {
     super.onChange(change);
     final state = change.currentState;
     if(state is AuthStateSignIn) {
       lastState = const AuthStateSignIn();
     }
     else if(state is AuthStateVerifyOtp) {
       lastState = const AuthStateSignIn();
     }
     else if(state is AuthStateSetProfile){
       lastState = AuthStateSetProfile(phone: state.phone);
     }
     else if(state is AuthStateTakePicture){
       lastState = AuthStateSetProfile(phone: state.phone);
     }
  }


  ///Start point
  startAuthFlow()
  async {
    emit(const AuthStateSignIn());
  }

  ///return the previous state.
  goBack(){
    emit(lastState);
  }

  ///Based on the internet connection, fetch the user from supabase using
  ///their phone. If there is no user with such phone
  ///then sign them up, else sign them in.
  ///In the case of any error, catch the Exception.
  /// Works with the AuthService.
  signIn({
    required String phone
  }) async {
    emit(const AuthStateSignIn(isLoading: true));
    try {
      final isConnected = await InternetConnection().hasInternetAccess;
      if(isConnected){
        final user = await userProvider.getUserFromSupabaseByPhone(phone);
        if (user == null) {
          await authProvider.signUp(phoneNumber: phone);
          emit(const AuthStateSignIn(isLoading: false));
          emit(AuthStateVerifyOtp(
            phone: phone,
          ));
        }
        else {
          await authProvider.signIn(phoneNumber: user.phoneNumber);
          emit(const AuthStateSignIn(isLoading: false));
          emit(AuthStateVerifyOtp(
            phone: user.phoneNumber,
          ));
        }
      }
      else {
        throw Exception('NO INTERNET!');
      }
    } on Exception catch (e) {
      emit(AuthStateSignIn(
          isLoading: false,
          hasException: true,
          errorMessage: e.toString()));
    }

  }

  ///Based on the connectivity, Verifies the OTP sent to the phone number.
  ///On successful verification, insert the user into the local database
  ///or replace the user if they already exist.
  verify ({
    required String phone,
    required String token
  }) async {
    emit(AuthStateVerifyOtp(phone: phone, isLoading: true));
    try {
      final isConnected = await InternetConnection().hasInternetAccess;
      if (isConnected) {
        await authProvider.verifyNumber(
          phoneNumber: phone,
          token: token,
        );
        emit(AuthStateVerifyOtp(
            phone: phone,
            isLoading: false));
        emit(AuthStateSetProfile(phone: phone));
      }
      else {
        throw Exception('NO INTERNET!');
      }
    }
    on Exception catch (e) {
      emit(AuthStateVerifyOtp(
        isLoading: false,
          phone: phone,
          hasException: true,
          errorMessage: e.toString()));
     }
  }

  ///Sets the user profile data --username and avatar -- to
  ///Supabase.
  setProfile({
    required String name, 
    required File avatarFile,
    required String phone
  }) async {
         emit(AuthStateSetProfile(isLoading: true, hasException: false, phone: phone));
         try {
           final isConnected = await InternetConnection().hasInternetAccess;
           if(isConnected){
             final user = await userProvider.getUserFromSupabaseByPhone(phone);
             if(user == null) throw Exception('No user found');
             if (name.isEmpty) throw Exception('Set your name');
             final currentUser = await userProvider.updateUserDataOnSupabase(
               id: user.id,
               name: name,
               avatar: avatarFile,
             );
             emit(AuthStateComplete(user: currentUser));
           }
           else {
              emit(AuthStateSetProfile(
                  file: avatarFile,
                  isLoading: false,
                  hasException: true,
                  phone: phone,
                  errorMessage: 'No internet connection'));
           }
         } on Exception catch(e){
           emit(AuthStateSetProfile(
               file: avatarFile,
               isLoading: false,
               hasException: true,
               phone: phone,
               errorMessage: e.toString()));
         }
  }


  ///Opens the device camera.
  openCamera({
    required String phone
  }) async {
    //get available cameras
    final cameras = await cameraProvider.getAvailableCameras();
    //get a cameraController
    final controller = cameraProvider.getCameraController(
        camera: cameras.first,
     );
    //initialize camera
    await cameraProvider.initializeCamera(
        cameraController: controller
    );
    emit(AuthStateTakePicture(
      isLoading: false,
      camera: cameras.first,
      controller: controller,
      phone: phone,
    ));
  }

  ///Takes a picture and emits the required state with the file.
  takePicture({
    required CameraController cameraController
  }) async {
    try {
      final currentState = state as AuthStateTakePicture;
      final picture = await cameraProvider.takePicture(cameraController: cameraController);
      emit(AuthStateSetProfile(
          file: picture,
          phone: currentState.phone
      ));
    } on Exception catch (e) {
      final currentState = state as AuthStateTakePicture;
      emit(AuthStateSetProfile(
          phone: currentState.phone,
          hasException: true,
          errorMessage: e.toString()));
    }
   }

   ///To change camera settings
  switchCameraOptions({
    required String phone,
    required bool isRearCam,
    required CameraController cameraController,
    ResolutionPreset? resolutionPreset
  }) async {
    try {
      final cameras = await cameraProvider.getAvailableCameras();
      cameraController = cameraProvider.getCameraController(
          camera: isRearCam ?
          cameras.first :
          cameras.last
      );
       await cameraProvider.initializeCamera(
          cameraController: cameraController
      );
      emit(AuthStateTakePicture(
        isLoading: false,
        camera: cameraController.description,
        controller: cameraController,
        phone: phone,
      ));
    } on Exception catch (e) {
      final currentState = state as AuthStateTakePicture;
      emit(AuthStateTakePicture(
        isLoading: false,
        camera: currentState.camera,
        controller: currentState.controller,
        hasException: true,
        errorMessage: e.toString(),
        phone: phone,
       ));
    }

  }

  ///Pick a file from gallery
  pickImage()
  async {
      try {
        final currentState = state as AuthStateTakePicture;
          File? file = await filePicker.pickImage();
          if(file == null) return;
          emit(AuthStateSetProfile(
              file: file,
              phone: currentState.phone
          ));
      } on Exception catch (e) {
        final currentState = state as AuthStateTakePicture;
        emit(AuthStateSetProfile(
            phone: currentState.phone,
            hasException: true,
            errorMessage: e.toString()));
      }
    }
}