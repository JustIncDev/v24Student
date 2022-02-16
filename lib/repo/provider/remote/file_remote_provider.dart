import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:v24_student_app/global/logger/logger.dart';

class FileRemoteProvider {
  FileRemoteProvider();

  Future<bool> uploadFile({
    required File file,
  }) async {
    return FirebaseStorage.instance.ref('files/${file.path}').putFile(file).then((_) {
      Log.info('Upload response success files/${file.path}');
      return true;
    }).catchError((e, s) {
      Log.error('Upload image error: ', exc: e, stackTrace: s);
      throw Exception();
      //   throw AppException.map(exp: e, stackTrace: s);
    });
  }
}
