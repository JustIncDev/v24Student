import 'package:flutter/cupertino.dart';
import 'package:v24_student_app/res/localization/id_values.dart';

class SimpleConfirmationDialog extends StatelessWidget {
  const SimpleConfirmationDialog({
    Key? key,
    this.positiveCallback,
    this.positiveText,
    this.titleId,
    this.content,
  }) : super(key: key);

  final VoidCallback? positiveCallback;
  final StringId? positiveText;
  final StringId? titleId;
  final StringId? content;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: _buildText(context, titleId),
      content: _buildText(context, content!),
      actions: [
        if (positiveCallback != null)
          CupertinoDialogAction(
            child: _buildText(context, positiveText!),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              positiveCallback!();
            },
          ),
        CupertinoDialogAction(
          child: _buildText(context, StringId.cancel),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        )
      ],
    );
  }

  Widget _buildText(context, StringId? textId) {
    return Text(textId == null ? '' : getStringById(context, textId));
  }

  void show(BuildContext context) => showCupertinoDialog(context: context, builder: (_) => this);
}
