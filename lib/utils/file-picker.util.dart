import 'dart:io';

import 'package:file_picker/file_picker.dart';

abstract class FilePickerUtil {
  static Future<File?> pickSingleFile({List<String>? allowedExtensions}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: allowedExtensions != null ? FileType.custom : FileType.any,
      allowedExtensions: allowedExtensions
    );
    if (result != null) {
      return File(result.files.single.path ?? "");
    }
    return null;
  }
}