import 'dart:io';

import 'package:v24_student_app/repo/base_repo.dart';

import 'provider/remote/file_remote_provider.dart';

///Repo for file feature
class FileRepo extends BaseRepo {
  FileRepo() : _fileRemoteProvider = FileRemoteProvider();

  final FileRemoteProvider _fileRemoteProvider;

  Future<bool> uploadImage({required File file}) async {
    return _fileRemoteProvider.uploadFile(file: file);
  }
}
