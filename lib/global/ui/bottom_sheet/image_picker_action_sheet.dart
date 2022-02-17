import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:v24_student_app/global/ui/dialog/simple_confirmation_dialog.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/localization/id_values.dart';
import 'package:v24_student_app/utils/image.dart';

Future<File?> showImagePickerActionSheet(
    BuildContext context, {
      CropStyle cropStyle = CropStyle.rectangle,
      VoidCallback? onDeleted,
      int maxWidth = 1000,
      int maxHeight = 1000,
      int compressQuality = 85,
    }) {
  return showCupertinoModalPopup<File>(
    context: context,
    builder: (_) {
      return ImagePickerActionSheet(
        cropStyle: cropStyle,
        onDeleted: onDeleted,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        compressQuality: compressQuality,
      );
    },
  );
}

class ImagePickerActionSheet extends StatelessWidget {
  const ImagePickerActionSheet({
    Key? key,
    required this.cropStyle,
    this.onDeleted,
    this.maxWidth = 1000,
    this.maxHeight = 1000,
    this.compressQuality = 85,
  }) : super(key: key);

  final CropStyle cropStyle;
  final VoidCallback? onDeleted;
  final int maxWidth;
  final int maxHeight;
  final int compressQuality;

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          child: Text(getStringById(context, StringId.takePhoto)),
          onPressed: () {
            _openImagePicker(context, ImageSource.camera);
          },
        ),
        CupertinoActionSheetAction(
          child: Text(getStringById(context, StringId.choosePhoto)),
          onPressed: () {
            _openImagePicker(context, ImageSource.gallery);
          },
        ),
        if (onDeleted != null)
          CupertinoActionSheetAction(
            child: Text(getStringById(context, StringId.deletePhoto), style: const TextStyle(color: AppColors.accent)),
            onPressed: () {
              _showConfirmationDialog(context);
            },
          ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        isDefaultAction: true,
        child: Text(getStringById(context, StringId.cancel)),
      ),
    );
  }

  Future<void> _openImagePicker(BuildContext context, ImageSource source) async {
    await ImageUtils.openImagePicker(
      imageSource: source,
      cropStyle: cropStyle,
      context: context,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      compressQuality: compressQuality,
    ).catchError((exc, s) {
      Navigator.of(context, rootNavigator: true).pop();
      // if (exc is AppException) {
      //   sendAppMessage(
      //     AppBusMessage(
      //       text: exc.getDisplayMessage(context),
      //       action: SnackBarAction(
      //         label: getStringById(context, StringId.allow),
      //         onPressed: () => openAppSettings(),
      //       ),
      //     ),
      //   );
      // } else {
      //   Log.error(exc.toString());
      // }
    });
  }

  void _showConfirmationDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
    SimpleConfirmationDialog(
      titleId: StringId.deletePhoto,
      positiveCallback: onDeleted,
      positiveText: StringId.delete,
      content: StringId.confirmDeleteAvatarDialog,
    ).show(context);
  }
}
