import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v24_student_app/feature/onboarding/onboarding_screen.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/global/navigation/root_router.dart';
import 'package:v24_student_app/global/navigation/screen_info.dart';
import 'package:v24_student_app/global/ui/button/primary_button.dart';
import 'package:v24_student_app/global/ui/button/social_button.dart';
import 'package:v24_student_app/global/ui/progress/progress_wall.dart';
import 'package:v24_student_app/global/ui/screen.dart';
import 'package:v24_student_app/global/ui/space.dart';
import 'package:v24_student_app/global/ui/text_field/app_text_field.dart';
import 'package:v24_student_app/global/ui/text_field/input_field_type.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';
import 'package:v24_student_app/res/icons.dart';
import 'package:v24_student_app/res/localization/id_values.dart';
import 'package:v24_student_app/utils/session_state.dart';
import 'package:v24_student_app/utils/ui.dart';

import 'bloc/login_bloc.dart';

class LoginScreen extends AppScreen {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();

  static Page buildPage({Map<String, Object>? params, required BlocFactory blocFactory}) {
    return UiUtils.createPlatformPage(
        key: const ValueKey('login'),
        child: BlocProvider(
          create: (ctx) {
            return blocFactory.createLoginBloc();
          },
          child: const LoginScreen(),
          lazy: false,
        ));
  }
}

class _LoginScreenState extends State<LoginScreen> {
  var _passwordVisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      _addLoginFieldInputEvent(InputFieldType.email, _emailController.text);
    });
    _passwordController.addListener(() {
      _addLoginFieldInputEvent(InputFieldType.password, _passwordController.text);
    });

    _emailFocusNode.addListener(() {
      _addLoginFieldValidateEvent(InputFieldType.email, _emailFocusNode);
    });
    _passwordFocusNode.addListener(() {
      _addLoginFieldValidateEvent(InputFieldType.password, _passwordFocusNode);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (previous, current) {
        return (previous.needFocusField != current.needFocusField) ||
            (previous.status != current.status);
      },
      listener: (context, state) {
        if (state.status == BaseScreenStatus.next) {
          RootRouter.of(context)
              ?.push(const ScreenInfo(name: ScreenName.surveys), replacement: true);
        }
        FocusNode? needFocus;
        TextEditingController? needController;
        if (!state.emailError.isNone() && state.loginType == LoginType.email) {
          needFocus = _emailFocusNode;
          needController = _emailController;
        } else if (!state.passwordError.isNone()) {
          needFocus = _passwordFocusNode;
          needController = _passwordController;
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
            WillPopScope(
              onWillPop: () => Future.value(false),
              child: Scaffold(
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
                                      getStringById(context, StringId.login),
                                      style: const TextStyle(
                                        color: AppColors.black,
                                        fontSize: 18.0,
                                        letterSpacing: -0.3,
                                      ).montserrat(fontWeight: AppFonts.semiBold),
                                    ),
                                  ),
                                  const VerticalSpace(55.5),
                                  AppTextField(
                                    controller: _emailController,
                                    focusNode: _emailFocusNode,
                                    labelText: getStringById(context, StringId.email),
                                    hintText: 'example@gmail.com',
                                    keyboardType: TextInputType.emailAddress,
                                    errorText: state.emailError.getMessage(context),
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
                                  const VerticalSpace(28.0),
                                  PrimaryButton(
                                    titleId: StringId.login,
                                    onPressed: state.isFillAllFields()
                                        ? () => BlocProvider.of<LoginBloc>(context)
                                                .add(LoginWithEmailPerformEvent(
                                              email: state.emailValue,
                                              password: state.passwordValue,
                                            ))
                                        : null,
                                  ),
                                  const VerticalSpace(35.0),
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: const Divider(
                                          color: AppColors.disabledColor,
                                          thickness: 1.0,
                                          endIndent: 20.0,
                                        ),
                                      ),
                                      Text(
                                        getStringById(context, StringId.or),
                                        style: const TextStyle(
                                          color: AppColors.black,
                                          fontSize: 13.0,
                                          letterSpacing: -0.3,
                                        ).montserrat(fontWeight: AppFonts.regular),
                                      ),
                                      const Expanded(
                                        child: const Divider(
                                          color: AppColors.disabledColor,
                                          thickness: 1.0,
                                          indent: 20.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const VerticalSpace(28.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SocialButton(
                                        type: SocialMediaType.apple,
                                        onTap: () => _onSocialButtonTap(SocialMediaType.apple),
                                      ),
                                      SocialButton(
                                        type: SocialMediaType.facebook,
                                        onTap: () => _onSocialButtonTap(SocialMediaType.facebook),
                                      ),
                                      SocialButton(
                                        type: SocialMediaType.google,
                                        onTap: () => _onSocialButtonTap(SocialMediaType.google),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Center(
                                    child: Text(
                                      getStringById(context, StringId.noAccount),
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
                                      RootRouter.of(context)?.push(
                                          const ScreenInfo(name: ScreenName.signUpCredentials));
                                    },
                                    child: Text(
                                      getStringById(context, StringId.register),
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
            ),
            state.status == BaseScreenStatus.lock ? const ProgressWall() : const Offstage(),
            if (state.showOnboarding) const OnboardingWidget(),
          ],
        );
      },
    );
  }

  void _addLoginFieldInputEvent(InputFieldType field, String value) {
    BlocProvider.of<LoginBloc>(context).add(LoginFieldInputEvent(field: field, value: value));
  }

  void _addLoginFieldValidateEvent(InputFieldType field, FocusNode focusNode) {
    if (!focusNode.hasFocus) {
      BlocProvider.of<LoginBloc>(context).add(LoginFieldValidateEvent(field: field));
    }
  }

  void _updateController(LoginState state) {
    if (_passwordController.text != state.passwordValue) {
      _passwordController.text = state.passwordValue;
    }
  }

  void _onSocialButtonTap(SocialMediaType type) {
    switch (type) {
      case SocialMediaType.apple:
        BlocProvider.of<LoginBloc>(context).add(LoginWithApplePerformEvent());
        break;
      case SocialMediaType.facebook:
        BlocProvider.of<LoginBloc>(context).add(LoginWithFacebookPerformEvent());
        break;
      case SocialMediaType.google:
        BlocProvider.of<LoginBloc>(context).add(LoginWithGooglePerformEvent());
        break;
    }
  }
}
