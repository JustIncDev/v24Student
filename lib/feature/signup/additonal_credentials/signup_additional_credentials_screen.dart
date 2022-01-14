import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:v24_student_app/feature/signup/additonal_credentials/bloc/sign_up_additional_credentials_bloc.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/global/navigation/root_router.dart';
import 'package:v24_student_app/global/navigation/screen_info.dart';
import 'package:v24_student_app/global/ui/button/primary_button.dart';
import 'package:v24_student_app/global/ui/progress/progress_wall.dart';
import 'package:v24_student_app/global/ui/space.dart';
import 'package:v24_student_app/global/widgets/date_picker.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';
import 'package:v24_student_app/res/localization/id_values.dart';
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
                                const VerticalSpace(14.5),
                                Center(
                                  child: Text(
                                    getStringById(context, StringId.additionalInfo),
                                    style: const TextStyle(
                                      color: AppColors.black30,
                                      fontSize: 12.0,
                                      letterSpacing: -0.3,
                                    ).montserrat(fontWeight: AppFonts.semiBold),
                                  ),
                                ),
                                const VerticalSpace(18.0),
                                Text(
                                  getStringById(context, StringId.gender),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(color: AppColors.royalBlue, fontSize: 13.0)
                                      .montserrat(fontWeight: AppFonts.semiBold),
                                ),
                                const VerticalSpace(5.5),
                                Container(
                                  width: double.infinity,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border:
                                          Border.all(color: AppColors.royalBlue.withOpacity(0.3))),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () {
                                                  BlocProvider.of<SignUpAdditionalCredentialsBloc>(
                                                          context)
                                                      .add(
                                                          SignUpAdditionalCredentialsSelectMaleEvent(
                                                              Gender.male));
                                                },
                                                child: Container(
                                                    margin: const EdgeInsets.all(2),
                                                    decoration: BoxDecoration(
                                                        color: state.gender == Gender.male
                                                            ? AppColors.royalBlue
                                                            : Colors.transparent,
                                                        borderRadius: BorderRadius.circular(5)),
                                                    child: Center(
                                                      child: Text(
                                                        getStringById(context, StringId.male),
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                                color: state.gender == Gender.male
                                                                    ? AppColors.white
                                                                    : AppColors.royalBlue,
                                                                fontSize: 13.0)
                                                            .montserrat(
                                                                fontWeight: AppFonts.semiBold),
                                                      ),
                                                    )),
                                              ))),
                                      Expanded(
                                          child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () {
                                                  BlocProvider.of<SignUpAdditionalCredentialsBloc>(
                                                          context)
                                                      .add(
                                                          SignUpAdditionalCredentialsSelectMaleEvent(
                                                              Gender.female));
                                                },
                                                child: Container(
                                                    margin: EdgeInsets.all(2),
                                                    decoration: BoxDecoration(
                                                        color: state.gender == Gender.female
                                                            ? AppColors.royalBlue
                                                            : Colors.transparent,
                                                        borderRadius: BorderRadius.circular(5)),
                                                    child: Center(
                                                      child: Text(
                                                        getStringById(context, StringId.female),
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                                color: state.gender == Gender.female
                                                                    ? AppColors.white
                                                                    : AppColors.royalBlue,
                                                                fontSize: 13.0)
                                                            .montserrat(
                                                                fontWeight: AppFonts.semiBold),
                                                      ),
                                                    )),
                                              ))),
                                    ],
                                  ),
                                ),
                                const VerticalSpace(18.0),
                                Text(
                                  getStringById(context, StringId.dateOfBirth),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(color: AppColors.royalBlue, fontSize: 13.0)
                                      .montserrat(fontWeight: AppFonts.semiBold),
                                ),
                                const VerticalSpace(5.5),
                                Row(
                                  children: [
                                    CustomDatePicker(
                                      dateFormat: 'MMM',
                                      looping: true,
                                      pickerTheme: const DateTimePickerTheme(
                                        backgroundColor: AppColors.white,
                                      ),
                                      onChange: (dateTime, selectedIndex) {
                                        BlocProvider.of<SignUpAdditionalCredentialsBloc>(context)
                                            .add(SignUpAdditionalCredentialsInputDateEvent(
                                                DateType.month, dateTime));
                                      },
                                    ),
                                    const HorizontalSpace(5.5),
                                    CustomDatePicker(
                                      dateFormat: 'dd',
                                      looping: true,
                                      pickerTheme: const DateTimePickerTheme(
                                        backgroundColor: AppColors.white,
                                      ),
                                      onChange: (dateTime, selectedIndex) {
                                        BlocProvider.of<SignUpAdditionalCredentialsBloc>(context)
                                            .add(SignUpAdditionalCredentialsInputDateEvent(
                                                DateType.day, dateTime));
                                      },
                                    ),
                                    const HorizontalSpace(5.5),
                                    CustomDatePicker(
                                      dateFormat: 'yyyy',
                                      looping: true,
                                      pickerTheme: const DateTimePickerTheme(
                                        backgroundColor: AppColors.white,
                                      ),
                                      onChange: (dateTime, selectedIndex) {
                                        BlocProvider.of<SignUpAdditionalCredentialsBloc>(context)
                                            .add(SignUpAdditionalCredentialsInputDateEvent(
                                                DateType.year, dateTime));
                                      },
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                PrimaryButton(
                                  titleId: StringId.finish,
                                  onPressed: () => _onFinishButtonTap(state),
                                ),
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

  void _onFinishButtonTap(SignUpAdditionalCredentialsState state) {
    BlocProvider.of<SignUpAdditionalCredentialsBloc>(context)
        .add(SignUpAdditionalCredentialsPerformEvent(
      firstName: widget.firstName,
      lastName: widget.lastName,
      email: widget.email,
      phoneNumber: widget.phoneNumber,
      country: widget.country,
      password: widget.password,
      gender: state.gender.name,
      birthdayDate:
          DateTime(state.year?.year ?? 0, state.month?.month ?? 0, state.day?.day ?? 0).toString(),
    ));
  }
}
