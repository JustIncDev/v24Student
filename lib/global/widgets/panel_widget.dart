import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';
import 'package:v24_student_app/res/icons.dart';

enum PanelButtonType {
  digit,
  clear,
  unlock,
  empty,
}

typedef OnPanelTap = void Function({String? value, bool? clear, bool? unlock});

class DigitPanelWidget extends StatefulWidget {
  const DigitPanelWidget({
    Key? key,
    required this.onPanelTap,
    this.smsCode = true,
  }) : super(key: key);

  final OnPanelTap onPanelTap;
  final bool smsCode;

  @override
  _DigitPanelWidgetState createState() => _DigitPanelWidgetState();
}

class _DigitPanelWidgetState extends State<DigitPanelWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: AppColors.white,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _KeyBoardButton(label: '1', onPressed: () => widget.onPanelTap(value: '1')),
                _KeyBoardButton(label: '2', onPressed: () => widget.onPanelTap(value: '2')),
                _KeyBoardButton(label: '3', onPressed: () => widget.onPanelTap(value: '3')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _KeyBoardButton(label: '4', onPressed: () => widget.onPanelTap(value: '4')),
                _KeyBoardButton(label: '5', onPressed: () => widget.onPanelTap(value: '5')),
                _KeyBoardButton(label: '6', onPressed: () => widget.onPanelTap(value: '6')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _KeyBoardButton(label: '7', onPressed: () => widget.onPanelTap(value: '7')),
                _KeyBoardButton(label: '8', onPressed: () => widget.onPanelTap(value: '8')),
                _KeyBoardButton(label: '9', onPressed: () => widget.onPanelTap(value: '9')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                widget.smsCode
                    ? const _KeyBoardButton(buttonType: PanelButtonType.empty)
                    : const _KeyBoardButton(buttonType: PanelButtonType.unlock),
                _KeyBoardButton(label: '0', onPressed: () => widget.onPanelTap(value: '0')),
                _KeyBoardButton(
                    buttonType: PanelButtonType.clear,
                    onPressed: () => widget.onPanelTap(clear: true)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _KeyBoardButton extends StatelessWidget {
  const _KeyBoardButton({
    Key? key,
    this.label,
    this.onPressed,
    this.buttonType = PanelButtonType.digit,
  }) : super(key: key);

  final String? label;
  final VoidCallback? onPressed;
  final PanelButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 90.0,
        height: 70.0,
        child: Center(
          child: _getPanelWidget(),
        ),
      ),
    );
  }

  Widget _getPanelWidget() {
    switch (buttonType) {
      case PanelButtonType.empty:
        return Container();
      case PanelButtonType.digit:
        return Text(
          label ?? '0',
          style: const TextStyle(fontSize: 32.0, color: AppColors.royalBlue)
              .montserrat(fontWeight: AppFonts.semiBold),
        );
      case PanelButtonType.clear:
        return SvgPicture.asset(
          AppIcons.clearIcon,
          color: AppColors.royalBlue,
        );
      case PanelButtonType.unlock:
        return SvgPicture.asset(AppIcons.faceIdIcon, color: AppColors.royalBlue);
    }
  }
}
