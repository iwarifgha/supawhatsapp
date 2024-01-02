import 'package:camera/camera.dart';
import 'dart:io';

class CameraRepo{
  Future<List<CameraDescription>> getAvailableCameras() async {
    try {
      final cameras = await availableCameras();
      return cameras;
    } on Exception catch (e) {
       throw Exception(e.toString());
    }
  }

  Future<File> takePicture({
    required CameraController cameraController
  }) async {
    final picture = await cameraController.takePicture();
    final file = File(picture.path);
    return file;
  }

  CameraController getCameraController({
    required CameraDescription camera,
    //required ResolutionPreset resolution
  }){
    final controller = CameraController(
        camera,
        ResolutionPreset.high,
        imageFormatGroup: ImageFormatGroup.jpeg
    );
    return controller;
  }

  initializeCamera({
    required CameraController cameraController
  }) async {
    try {
      await cameraController.initialize();
    } on Exception catch (e) {
      Exception(e.toString());
    }
  }

}