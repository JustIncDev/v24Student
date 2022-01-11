import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/global/ui/space.dart';
import 'package:v24_student_app/global/widgets/panel_widget.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';
import 'package:v24_student_app/res/icons.dart';
import 'package:v24_student_app/res/localization/id_values.dart';
import 'package:v24_student_app/utils/ui.dart';

import 'bloc/signup_code_bloc.dart';

class SignUpCodeScreen extends StatefulWidget {
  const SignUpCodeScreen({Key? key, required this.phone}) : super(key: key);

  final String phone;

  @override
  _SignUpCodeScreenState createState() => _SignUpCodeScreenState();

  static Page buildPage({Map<String, Object>? params, required BlocFactory blocFactory}) {
    late String phoneValue;
    if (params != null) {
      phoneValue = params['phone'] as String;
    }
    return UiUtils.createPlatformPage(
      key: const ValueKey('signup-code'),
      child: BlocProvider(
        create: (ctx) {
          return blocFactory.createSignUpCodeBloc();
        },
        child: SignUpCodeScreen(phone: phoneValue),
        lazy: false,
      ),
    );
  }
}

class _SignUpCodeScreenState extends State<SignUpCodeScreen> {
  final firstDigitFocusNode = FocusNode();
  final secondDigitFocusNode = FocusNode();
  final thirdDigitFocusNode = FocusNode();
  final fourthDigitFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    firstDigitFocusNode.requestFocus();
  }

  @override
  void dispose() {
    firstDigitFocusNode.dispose();
    secondDigitFocusNode.dispose();
    thirdDigitFocusNode.dispose();
    fourthDigitFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCodeBloc, SignUpCodeState>(
      listenWhen: (previous, current) {
        return (previous.currentCodePosition != current.currentCodePosition);
      },
      listener: (context, state) {
        if (state.currentCodePosition == 0) {
          firstDigitFocusNode.requestFocus();
        } else if (state.currentCodePosition == 1) {
          secondDigitFocusNode.requestFocus();
        } else if (state.currentCodePosition == 2) {
          thirdDigitFocusNode.requestFocus();
        } else {
          fourthDigitFocusNode.requestFocus();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: [0.35, 0.55, 0.88],
                colors: [
                  AppColors.blueRaspberry,
                  AppColors.hooloovooBlue,
                  AppColors.sixteenMillionPink,
                ],
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.55,
                  width: MediaQuery.of(context).size.width,
                  child: CustomPaint(
                    painter: BackgroundPainter(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        children: [
                          const VerticalSpace(93.0),
                          SvgPicture.asset(AppIcons.phoneSmsIcon),
                          const VerticalSpace(28.0),
                          Text(
                            getStringById(context, StringId.phoneConfirmation),
                            style: const TextStyle(fontSize: 18.0, color: AppColors.white)
                                .montserrat(fontWeight: AppFonts.semiBold),
                          ),
                          const VerticalSpace(10.0),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: getStringById(context, StringId.enterCodeMessage),
                                  style: const TextStyle(fontSize: 14.0, color: AppColors.white)
                                      .montserrat(fontWeight: AppFonts.regular)),
                              TextSpan(
                                  text: widget.phone,
                                  style: const TextStyle(fontSize: 14.0, color: AppColors.white)
                                      .montserrat(fontWeight: AppFonts.semiBold)),
                            ]),
                          ),
                          const VerticalSpace(60.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _CodeFieldWidget(
                                value: state.firstCodeValue,
                                focusNode: firstDigitFocusNode,
                                showCursor: state.showCursor(0),
                              ),
                              _CodeFieldWidget(
                                value: state.secondCodeValue,
                                focusNode: secondDigitFocusNode,
                                showCursor: state.showCursor(1),
                              ),
                              _CodeFieldWidget(
                                value: state.thirdCodeValue,
                                focusNode: thirdDigitFocusNode,
                                showCursor: state.showCursor(2),
                              ),
                              _CodeFieldWidget(
                                value: state.fourthCodeValue,
                                focusNode: fourthDigitFocusNode,
                                showCursor: state.showCursor(3),
                              ),
                            ],
                          ),
                          const VerticalSpace(40.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: null,
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                                      (states) {
                                    return EdgeInsets.zero;
                                  }),
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppIcons.arrowLeftIcon),
                                    const HorizontalSpace(11.0),
                                    Text(
                                      getStringById(context, StringId.changePhone),
                                      style: const TextStyle(fontSize: 14.0, color: AppColors.white)
                                          .montserrat(fontWeight: AppFonts.semiBold),
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: null,
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                                          (states) {
                                        return EdgeInsets.zero;
                                      }),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      getStringById(context, StringId.resendCode),
                                      style: const TextStyle(fontSize: 14.0, color: AppColors.white)
                                          .montserrat(fontWeight: AppFonts.semiBold),
                                    ),
                                    //Make timer for resend code
                                    Text(
                                      ' 1:31',
                                      style: const TextStyle(fontSize: 14.0, color: AppColors.white)
                                          .montserrat(fontWeight: AppFonts.semiBold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                DigitPanelWidget(
                  onPanelTap: ({clear, unlock, value}) {
                    if (value != null) {
                      BlocProvider.of<SignUpCodeBloc>(context).add(SignUpCodeInputEvent(value));
                    }
                    if (clear != null) {
                      BlocProvider.of<SignUpCodeBloc>(context).add(SignUpCodeClearEvent());
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CodeFieldWidget extends StatefulWidget {
  const _CodeFieldWidget({
    Key? key,
    this.focusNode,
    this.value,
    this.showCursor = false,
  }) : super(key: key);

  final FocusNode? focusNode;
  final String? value;

  /// Cursor for the empty value
  final bool showCursor;

  @override
  State<_CodeFieldWidget> createState() => _CodeFieldWidgetState();
}

class _CodeFieldWidgetState extends State<_CodeFieldWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget fieldValue = widget.showCursor
        ? Text(
            '|',
            style: const TextStyle(fontSize: 24.0, color: AppColors.white)
                .montserrat(fontWeight: AppFonts.light),
          )
        : Text(
            widget.value ?? '',
            style: const TextStyle(fontSize: 24.0, color: AppColors.white)
                .montserrat(fontWeight: AppFonts.semiBold),
          );

    return Focus(
      focusNode: widget.focusNode,
      child: Container(
        width: 60.0,
        height: 60.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: AppColors.white.withOpacity(0.3)),
          color: AppColors.white.withOpacity(0.1),
        ),
        child: Center(
          child: widget.showCursor
              ? FadeTransition(
                  opacity: _animationController,
                  child: fieldValue,
                )
              : fieldValue,
        ),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;

    final firstBasicPoint = Offset(0.0, height * 0.24);
    final secondBasicPoint = Offset(0.0, height * 0.45);
    final thirdBasicPoint = Offset(width * 0.34, 0.0);
    final fourthBasicPoint = Offset(width * 0.48, 0.0);

    final firstHandlePoint = Offset(width * 0.08, height * 0.1);
    final secondHandlePoint = Offset(width * 0.2, height * 0.45);
    final thirdHandlePoint = Offset(width * 0.31, height * 0.25);
    final fourthHandlePoint = Offset(width * 0.18, height * 0.39);
    final fifthHandlePoint = Offset(width * 0.46, height * 0.25);
    final sixthHandlePoint = Offset(width * 0.37, height * 0.15);

    final leftCornerPath = Path()
      ..moveTo(firstBasicPoint.dx, firstBasicPoint.dy)
      ..cubicTo(
        firstHandlePoint.dx,
        firstHandlePoint.dy,
        secondHandlePoint.dx,
        secondHandlePoint.dy,
        thirdBasicPoint.dx,
        thirdBasicPoint.dy,
      )
      ..lineTo(fourthBasicPoint.dx, fourthBasicPoint.dy)
      ..cubicTo(
        sixthHandlePoint.dx,
        sixthHandlePoint.dy,
        fifthHandlePoint.dx,
        fifthHandlePoint.dy,
        secondBasicPoint.dx,
        secondBasicPoint.dy,
      )
      ..close();

    final leftCornerPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          AppColors.hooloovooBlue,
          AppColors.sixteenMillionPink,
        ],
        stops: [
          0.01,
          0.7,
        ],
      ).createShader(Rect.largest);

    canvas.drawPath(leftCornerPath, leftCornerPaint);

    final circlePaint = Paint()
      ..color = AppColors.royalBlue
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(
      Offset(width * 0.08, height * 0.28),
      15.0,
      circlePaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
