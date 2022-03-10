import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:v24_student_app/res/localization/id_values.dart';

class PermissionUtils {
  ///Request permission for getting images
  static Future<bool> requestImagePermission(ImageSource imageSource) async {
    Permission permission;
    StringId messageId;
    var permissionDisplayed = false;

    switch (imageSource) {
      case ImageSource.camera:
        permission = Permission.camera;
        messageId = StringId.allowAccessCamera;
        break;
      case ImageSource.gallery:
        permission = Permission.photos;
        messageId = StringId.allowAccessCameraRoll;
        break;
    }

    var permissionStatus = await permission.status;

    if (permissionStatus.isDenied) {
      permissionStatus = await permission.request();
      permissionDisplayed = true;
    }

    if (permissionStatus.isPermanentlyDenied && !permissionDisplayed) {
      // throw UtilException(messageId: messageId);
      throw Exception();
    }
    return permissionStatus.isGranted || permissionStatus.isLimited;
  }

  ///Request permission for receiving notifications
  static Future<void> requestNotificationPermission() async {
    var permission = Permission.notification;
    await permission.request();
  }
}
