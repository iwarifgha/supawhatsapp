import 'dart:io';

import 'package:file_picker/file_picker.dart';

class MyFilePicker{

  Future<File?> pickImage() async {
    FilePickerResult? file = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if(file == null){
      return null;
    }
    File newFile = File(file.files.single.path!);
    return newFile;
  }
}