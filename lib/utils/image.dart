import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:v24_student_app/utils/permission.dart';

class ImageUtils {
  ///Manage image picker
  static Future<void> openImagePicker({
    required ImageSource imageSource,
    required CropStyle cropStyle,
    required BuildContext context,
    int maxWidth = 1000,
    int maxHeight = 1000,
    int compressQuality = 85,
  }) async {
    final _picker = ImagePicker();
    await PermissionUtils.requestImagePermission(imageSource).then((permissionGranted) {
      if (!permissionGranted) {
        Navigator.of(context, rootNavigator: true).pop();
      } else {
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            transitionDuration: Duration.zero,
            pageBuilder: (context, _, __) {
              return const Offstage();
            },
          ),
        );
        _picker.pickImage(source: imageSource).then((pickedFile) {
          if (pickedFile != null) {
            ImageCropper.cropImage(
              sourcePath: pickedFile.path,
              compressFormat: ImageCompressFormat.png,
              maxWidth: maxWidth,
              maxHeight: maxHeight,
              compressQuality: compressQuality,
              cropStyle: cropStyle,
            ).then((croppedImage) {
              Navigator.of(context, rootNavigator: true).pop();
              if (croppedImage != null) {
                Navigator.of(context, rootNavigator: true).pop(croppedImage);
              } else {
                Navigator.of(context, rootNavigator: true).pop();
              }
            }).catchError((e, s) {
              // throw UtilException(messageId: StringId.failedUploadFile, cause: e, stackTrace: s);
              throw Exception();
            });
          } else {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.of(context, rootNavigator: true).pop();
          }
        }).catchError((e, s) {
          // throw UtilException(messageId: StringId.failedUploadFile, cause: e, stackTrace: s);
          throw Exception();
        });
      }
    });
  }
}