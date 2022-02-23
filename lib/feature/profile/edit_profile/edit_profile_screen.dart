import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:v24_student_app/feature/profile/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/global/navigation/root_router.dart';
import 'package:v24_student_app/global/ui/bottom_sheet/image_picker_action_sheet.dart';
import 'package:v24_student_app/global/ui/button/primary_button.dart';
import 'package:v24_student_app/global/ui/progress/progress_wall.dart';
import 'package:v24_student_app/global/ui/space.dart';
import 'package:v24_student_app/global/ui/text_field/app_text_field.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';
import 'package:v24_student_app/res/icons.dart';
import 'package:v24_student_app/res/localization/id_values.dart';
import 'package:v24_student_app/utils/ui.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();

  static Page buildPage({Map<String, Object>? params, required BlocFactory blocFactory}) {
    return UiUtils.createPlatformPage(
      key: const ValueKey('edit_profile'),
      child: BlocProvider(
        create: (ctx) {
          return blocFactory.createEditProfileBloc();
        },
        child: const EditProfileScreen(),
        lazy: false,
      ),
    );
  }
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _firstNameController.addListener(
        () => _listenInputField(EditProfileField.firstName, _firstNameController.text));

    _lastNameController
        .addListener(() => _listenInputField(EditProfileField.lastName, _lastNameController.text));

    _emailController
        .addListener(() => _listenInputField(EditProfileField.email, _emailController.text));

    _firstNameFocusNode.addListener(
        () => _changeFieldCursorPosition(_firstNameFocusNode, EditProfileField.firstName));

    _lastNameFocusNode.addListener(
        () => _changeFieldCursorPosition(_lastNameFocusNode, EditProfileField.lastName));

    _emailFocusNode
        .addListener(() => _changeFieldCursorPosition(_emailFocusNode, EditProfileField.email));
  }

  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileBloc, EditProfileState>(
      listenWhen: (previous, current) =>
          previous.needFocusField != current.needFocusField ||
          current.status == BaseScreenStatus.next,
      listener: _listenEditProfileBloc,
      builder: (context, state) {
        _updateController(state);
        return Stack(
          children: [
            Scaffold(
              backgroundColor: AppColors.white,
              body: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints viewportConstraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: SafeArea(
                          top: false,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const VerticalSpace(26.5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: SvgPicture.asset(
                                        AppIcons.arrowLeftIcon,
                                        color: AppColors.black,
                                        width: 18.0,
                                        height: 18.0,
                                      ),
                                      iconSize: 18.0,
                                      onPressed: _onBackButtonPressed,
                                    ),
                                    Center(
                                      child: Text(
                                        getStringById(context, StringId.editProfile),
                                        style: const TextStyle(
                                          color: AppColors.black,
                                          fontSize: 18.0,
                                          letterSpacing: -0.3,
                                        ).montserrat(fontWeight: AppFonts.semiBold),
                                      ),
                                    ),
                                    IconButton(
                                      icon: SvgPicture.asset(AppIcons.arrowLeftIcon),
                                      onPressed: null,
                                      color: AppColors.transparent,
                                    ),
                                  ],
                                ),
                                const VerticalSpace(34.5),
                                _AvatarWidget(avatar: state.avatar),
                                const VerticalSpace(18.0),
                                PrimaryButton(
                                  titleId: StringId.uploadPhoto,
                                  onPressed: () => _onUploadButtonTap(state),
                                  icon: SvgPicture.asset(AppIcons.uploadIcon),
                                  style: PrimaryButtonStyle.disabled,
                                ),
                                const VerticalSpace(18.0),
                                Row(
                                  children: [
                                    Expanded(
                                      child: AppTextField(
                                        controller: _firstNameController,
                                        focusNode: _firstNameFocusNode,
                                        labelText: getStringById(context, StringId.firstName),
                                        errorText: state.firstNameError.getMessage(context),
                                      ),
                                    ),
                                    const HorizontalSpace(18.0),
                                    Expanded(
                                      child: AppTextField(
                                        controller: _lastNameController,
                                        focusNode: _lastNameFocusNode,
                                        labelText: getStringById(context, StringId.lastName),
                                        errorText: state.lastNameError.getMessage(context),
                                      ),
                                    ),
                                  ],
                                ),
                                AppTextField(
                                  controller: _emailController,
                                  focusNode: _emailFocusNode,
                                  labelText: getStringById(context, StringId.email),
                                  hintText: 'example@gmail.com',
                                  errorText: state.emailError.getMessage(context),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                const Spacer(),
                                PrimaryButton(
                                  titleId: StringId.save,
                                  onPressed:
                                      state.hasChanges() ? () => _onSaveButtonTap(state) : null,
                                ),
                                const VerticalSpace(21.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            state.status == BaseScreenStatus.lock ? const ProgressWall() : const Offstage(),
          ],
        );
      },
    );
  }

  void _listenEditProfileBloc(BuildContext context, EditProfileState state) {
    if (state.status == BaseScreenStatus.next) {
      RootRouter.of(context)?.pop();
    } else {
      if (!state.firstNameError.isNone()) {
        _focusFieldWithError(_firstNameController, _firstNameFocusNode);
      } else if (!state.lastNameError.isNone()) {
        _focusFieldWithError(_lastNameController, _lastNameFocusNode);
      } else if (!state.emailError.isNone()) {
        _focusFieldWithError(_emailController, _emailFocusNode);
      }
    }
  }

  void _focusFieldWithError(TextEditingController controller, FocusNode focusNode) {
    if (!focusNode.hasFocus) {
      controller.selection =
          TextSelection.fromPosition(TextPosition(offset: controller.text.length));
      focusNode.requestFocus();
    }
  }

  void _onSaveButtonTap(EditProfileState state) {
    if (!state.isFieldError() && state.hasChanges()) {
      BlocProvider.of<EditProfileBloc>(context).add(EditProfilePerformEvent());
    }
    return null;
  }

  void _onUploadButtonTap(EditProfileState state) {
    var onDeleted =
        _emptyImage(state.avatar.url, state.avatar.file) ? _onDeleteAvatarButtonTap : null;
    showImagePickerActionSheet(context, cropStyle: CropStyle.circle, onDeleted: onDeleted)
        .then((file) {
      if (file != null) {
        BlocProvider.of<EditProfileBloc>(context)
            .add(EditProfileUploadAvatarImageEvent(file: file));
      }
    });
  }

  bool _emptyImage(String? url, File? file) {
    return (url != null && file == null) || file != null;
  }

  void _onDeleteAvatarButtonTap() {
    BlocProvider.of<EditProfileBloc>(context).add(EditProfileUploadAvatarImageEvent());
  }

  void _changeFieldCursorPosition(FocusNode focusNode, EditProfileField field) {
    if (!focusNode.hasFocus) {
      BlocProvider.of<EditProfileBloc>(context).add(EditProfileFieldValidateEvent(field: field));
    }
  }

  void _listenInputField(EditProfileField field, String value) {
    BlocProvider.of<EditProfileBloc>(context)
        .add(EditProfileFieldInputEvent(field: field, value: value));
  }

  void _updateController(EditProfileState state) {
    if (_firstNameController.text != state.firstNameValue) {
      _firstNameController.text = state.firstNameValue;
    }
    if (_lastNameController.text != state.lastNameValue) {
      _lastNameController.text = state.lastNameValue;
    }
    if (_emailController.text != state.emailValue) {
      _emailController.text = state.emailValue;
    }
  }

  void _onBackButtonPressed() {
    RootRouter.of(context)?.pop();
  }
}

class _AvatarWidget extends StatelessWidget {
  const _AvatarWidget({
    Key? key,
    required this.avatar,
  }) : super(key: key);

  final Avatar avatar;

  @override
  Widget build(BuildContext context) {
    var avatarUrl = avatar.url;
    var avatarFile = avatar.file;

    ImageProvider? avatarImageProvider;

    if (avatarUrl != null) {
      avatarImageProvider = CachedNetworkImageProvider(avatarUrl);
    } else if (avatarFile != null) {
      avatarImageProvider = FileImage(avatarFile);
    }

    return CircleAvatar(
      radius: 70.0,
      backgroundColor: AppColors.royalBlue,
      foregroundImage: avatarImageProvider,
      child: SvgPicture.asset(
        AppIcons.myProfileIcon,
        width: 72,
        height: 72,
      ),
    );
  }
}
