import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/global/navigation/root_router.dart';
import 'package:v24_student_app/global/navigation/screen_info.dart';
import 'package:v24_student_app/global/ui/button/primary_button.dart';
import 'package:v24_student_app/global/ui/progress/progress_wall.dart';
import 'package:v24_student_app/global/ui/space.dart';
import 'package:v24_student_app/global/ui/text_field/app_text_field.dart';
import 'package:v24_student_app/global/ui/text_field/input_field_type.dart';
import 'package:v24_student_app/global/ui/text_field/number_text_field.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';
import 'package:v24_student_app/res/icons.dart';
import 'package:v24_student_app/res/localization/id_values.dart';
import 'package:v24_student_app/utils/ui.dart';

import 'bloc/signup_credentials_bloc.dart';

class SignUpCredentialsScreen extends StatefulWidget {
  const SignUpCredentialsScreen({Key? key}) : super(key: key);

  @override
  _SignUpCredentialsScreenState createState() => _SignUpCredentialsScreenState();

  static Page buildPage({Map<String, Object>? params, required BlocFactory blocFactory}) {
    return UiUtils.createPlatformPage(
      key: const ValueKey('signup-credentials'),
      child: BlocProvider(
        create: (ctx) {
          return blocFactory.createSignUpCredentialsBloc();
        },
        child: const SignUpCredentialsScreen(),
        lazy: false,
      ),
    );
  }
}

class _SignUpCredentialsScreenState extends State<SignUpCredentialsScreen> {
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var _passwordVisible = false;
  var _confirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();

    _firstNameController
        .addListener(() => _listenInputField(InputFieldType.firstName, _firstNameController.text));

    _lastNameController
        .addListener(() => _listenInputField(InputFieldType.lastName, _lastNameController.text));

    _phoneController
        .addListener(() => _listenInputField(InputFieldType.phone, _phoneController.text));

    _emailController
        .addListener(() => _listenInputField(InputFieldType.email, _emailController.text));

    _passwordController
        .addListener(() => _listenInputField(InputFieldType.password, _passwordController.text));

    confirmPasswordController.addListener(
        () => _listenInputField(InputFieldType.confirmPassword, confirmPasswordController.text));

    _firstNameFocusNode.addListener(
        () => _changeFieldCursorPosition(_firstNameFocusNode, InputFieldType.firstName));

    _lastNameFocusNode
        .addListener(() => _changeFieldCursorPosition(_lastNameFocusNode, InputFieldType.lastName));

    _phoneFocusNode
        .addListener(() => _changeFieldCursorPosition(_phoneFocusNode, InputFieldType.phone));

    _emailFocusNode
        .addListener(() => _changeFieldCursorPosition(_emailFocusNode, InputFieldType.email));

    _passwordFocusNode
        .addListener(() => _changeFieldCursorPosition(_passwordFocusNode, InputFieldType.password));

    _confirmPasswordFocusNode.addListener(() =>
        _changeFieldCursorPosition(_confirmPasswordFocusNode, InputFieldType.confirmPassword));
  }

  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCredentialsBloc, SignUpCredentialsState>(
      listenWhen: (previous, current) {
        return (previous.needFocusField != current.needFocusField) ||
            (previous.status != current.status && current.status == BaseScreenStatus.next);
      },
      listener: (context, state) {
        if (state.status == BaseScreenStatus.next) {
          RootRouter.of(context)?.push(ScreenInfo(name: ScreenName.signUpAdditional, params: {
            'firstName': state.firstNameValue,
            'lastName': state.lastNameValue,
            'email': state.emailValue,
            'phoneNumber': state.phoneValue,
            'country': state.countryNameValue,
            'password': state.passwordValue,
          }));
        }
        FocusNode? needFocus;
        TextEditingController? needController;
        if (!state.firstNameError.isNone()) {
          needFocus = _firstNameFocusNode;
          needController = _firstNameController;
        } else if (!state.lastNameError.isNone()) {
          needFocus = _lastNameFocusNode;
          needController = _lastNameController;
        } else if (!state.phoneError.isNone()) {
          needFocus = _phoneFocusNode;
          needController = _phoneController;
        } else if (!state.emailError.isNone()) {
          needFocus = _emailFocusNode;
          needController = _emailController;
        } else if (!state.passwordError.isNone()) {
          needFocus = _passwordFocusNode;
          needController = _passwordController;
        } else if (!state.confirmError.isNone()) {
          needFocus = _confirmPasswordFocusNode;
          needController = confirmPasswordController;
        }
        if (needFocus != null && !needFocus.hasFocus) {
          needController?.selection =
              TextSelection.fromPosition(TextPosition(offset: needController.text.length));
          needFocus.requestFocus();
        }
      },
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
                                const VerticalSpace(58.5),
                                Center(
                                  child: Text(
                                    getStringById(context, StringId.registration),
                                    style: const TextStyle(
                                      color: AppColors.black,
                                      fontSize: 18.0,
                                      letterSpacing: -0.3,
                                    ).montserrat(fontWeight: AppFonts.semiBold),
                                  ),
                                ),
                                const VerticalSpace(34.5),
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
                                const VerticalSpace(18.0),
                                AppTextField(
                                  controller: _emailController,
                                  focusNode: _emailFocusNode,
                                  labelText: getStringById(context, StringId.email),
                                  hintText: 'example@gmail.com',
                                  errorText: state.emailError.getMessage(context),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                const VerticalSpace(18.0),
                                PhoneNumberTextField(
                                  controller: _phoneController,
                                  focusNode: _phoneFocusNode,
                                  labelText: getStringById(context, StringId.phoneNumber),
                                  errorText: state.phoneError.getMessage(context),
                                  onCountryChanged: (String countryName) {
                                    _listenInputField(InputFieldType.country, countryName);
                                  },
                                ),
                                const VerticalSpace(18.0),
                                AppTextField(
                                  controller: _passwordController,
                                  focusNode: _passwordFocusNode,
                                  labelText: getStringById(context, StringId.password),
                                  errorText: state.passwordError.getMessage(context),
                                  obscureText: !_passwordVisible,
                                  keyboardType: TextInputType.visiblePassword,
                                  suffixIcon: IconButton(
                                    padding: const EdgeInsets.all(0),
                                    icon: !_passwordVisible
                                        ? const Image(
                                            image: AppIcons.eyeOpenAsset,
                                            color: AppColors.borderColor,
                                          )
                                        : const Image(
                                            image: AppIcons.eyeCloseAsset,
                                            color: AppColors.borderColor,
                                          ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                ),
                                const VerticalSpace(18.0),
                                AppTextField(
                                  controller: confirmPasswordController,
                                  focusNode: _confirmPasswordFocusNode,
                                  labelText: getStringById(context, StringId.confirmPassword),
                                  errorText: state.confirmError.getMessage(context),
                                  obscureText: !_confirmPasswordVisible,
                                  keyboardType: TextInputType.visiblePassword,
                                  suffixIcon: IconButton(
                                    padding: const EdgeInsets.all(0),
                                    icon: !_confirmPasswordVisible
                                        ? const Image(
                                            image: AppIcons.eyeOpenAsset,
                                            color: AppColors.borderColor,
                                          )
                                        : const Image(
                                            image: AppIcons.eyeCloseAsset,
                                            color: AppColors.borderColor,
                                          ),
                                    onPressed: () {
                                      setState(() {
                                        _confirmPasswordVisible = !_confirmPasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                                const VerticalSpace(28.0),
                                PrimaryButton(
                                  titleId: StringId.continueText,
                                  onPressed: state.isFillAllFields()
                                      ? () => _onContinueButtonTap(state)
                                      : null,
                                ),
                                const Spacer(),
                                const VerticalSpace(28.0),
                                Center(
                                  child: Text(
                                    getStringById(context, StringId.alreadyHaveMessage),
                                    style: const TextStyle(
                                      color: AppColors.black,
                                      fontSize: 13.0,
                                      letterSpacing: -0.3,
                                    ).montserrat(fontWeight: AppFonts.regular),
                                  ),
                                ),
                                const VerticalSpace(10.0),
                                TextButton(
                                  onPressed: () {
                                    RootRouter.of(context)
                                        ?.first(const ScreenInfo(name: ScreenName.login));
                                  },
                                  child: Text(
                                    getStringById(context, StringId.signIn),
                                    style: const TextStyle(
                                      color: AppColors.royalBlue,
                                      decoration: TextDecoration.underline,
                                      fontSize: 13.0,
                                      letterSpacing: -0.3,
                                    ).montserrat(fontWeight: AppFonts.semiBold),
                                  ),
                                ),
                                const VerticalSpace(8),
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

  void _onContinueButtonTap(SignUpCredentialsState state) {
    BlocProvider.of<SignUpCredentialsBloc>(context).add(SignUpPerformEvent());
  }

  void _changeFieldCursorPosition(FocusNode focusNode, InputFieldType field) {
    if (!focusNode.hasFocus) {
      BlocProvider.of<SignUpCredentialsBloc>(context).add(SignUpFieldValidateEvent(field: field));
    }
  }

  void _listenInputField(InputFieldType field, String value) {
    BlocProvider.of<SignUpCredentialsBloc>(context)
        .add(SignUpFieldInputEvent(field: field, value: value));
  }

  void _updateController(SignUpCredentialsState state) {
    if (_firstNameController.text != state.firstNameValue) {
      _firstNameController.text = state.firstNameValue;
    }
    if (_lastNameController.text != state.lastNameValue) {
      _lastNameController.text = state.lastNameValue;
    }
    if (_phoneController.text != state.phoneValue) {
      _phoneController.text = state.phoneValue;
    }
    if (_emailController.text != state.emailValue) {
      _emailController.text = state.emailValue;
    }
    if (_passwordController.text != state.passwordValue) {
      _passwordController.text = state.passwordValue;
    }
    if (confirmPasswordController.text != state.confirmValue) {
      confirmPasswordController.text = state.confirmValue;
    }
  }
}
