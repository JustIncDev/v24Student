import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v24_student_app/feature/signup/additonal_credentials/bloc/sign_up_additional_credentials_bloc.dart';
import 'package:v24_student_app/feature/signup/additonal_credentials/widgets/signup_additional_screen_body.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/global/navigation/root_router.dart';
import 'package:v24_student_app/global/navigation/screen_info.dart';
import 'package:v24_student_app/global/ui/progress/progress_wall.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/utils/ui.dart';

class SignUpAdditionalCredentialsScreen extends StatefulWidget {
  const SignUpAdditionalCredentialsScreen({
    Key? key,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.email,
    this.country,
    this.password,
  }) : super(key: key);

  final String? firstName;
  final String? lastName;
  final String? email;
  final String? country;
  final String? password;
  final String? phoneNumber;

  @override
  _SignUpAdditionalCredentialsScreenState createState() =>
      _SignUpAdditionalCredentialsScreenState();

  static Page buildPage({Map<String, Object>? params, required BlocFactory blocFactory}) {
    String? fistName;
    String? lastName;
    String? email;
    String? country;
    String? phoneNumber;
    String? password;
    if (params != null) {
      fistName = params['firstName'] as String?;
      lastName = params['lastName'] as String?;
      email = params['email'] as String?;
      country = params['country'] as String?;
      phoneNumber = params['phoneNumber'] as String?;
      password = params['password'] as String?;
    }

    return UiUtils.createPlatformPage(
      key: const ValueKey('signup-additional'),
      child: BlocProvider(
        create: (ctx) {
          return blocFactory.createSignUpAdditionalCredentialsBloc();
        },
        child: SignUpAdditionalCredentialsScreen(
          firstName: fistName,
          lastName: lastName,
          email: email,
          phoneNumber: phoneNumber,
          country: country,
          password: password,
        ),
        lazy: false,
      ),
    );
  }
}

class _SignUpAdditionalCredentialsScreenState extends State<SignUpAdditionalCredentialsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpAdditionalCredentialsBloc, SignUpAdditionalCredentialsState>(
      listenWhen: (previous, current) {
        return (previous.status != current.status && current.status == BaseScreenStatus.next);
      },
      listener: (context, state) {
        if (state.status == BaseScreenStatus.next) {
          RootRouter.of(context)?.push(
              ScreenInfo(name: ScreenName.signUpCode, params: {'phone': widget.phoneNumber ?? ''}),
              replacement: true);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: AppColors.white,
              body: SignUpAdditionalScreenBody(state: state),
            ),
            state.status == BaseScreenStatus.lock ? const ProgressWall() : const Offstage(),
          ],
        );
      },
    );
  }
}
