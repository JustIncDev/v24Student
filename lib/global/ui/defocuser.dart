import 'package:flutter/material.dart';

class Defocuser extends StatefulWidget {
  const Defocuser({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _DefocuserState createState() {
    return _DefocuserState();
  }
}

class _DefocuserState extends State<Defocuser> {
  final FocusNode _hiddenFocusNode = FocusNode();
  bool focusIsAttached = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!focusIsAttached) {
      _hiddenFocusNode.attach(context);
      focusIsAttached = true;
    }
  }

  @override
  void dispose() {
    _hiddenFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_hiddenFocusNode);
      },
      child: widget.child,
    );
  }
}
