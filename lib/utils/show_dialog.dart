import 'package:flutter/cupertino.dart';

void dialog(
  BuildContext context,
  String title,
  String dialog,
  List<Widget> action,
  // CupertinoDialogAction cupertinoDialogAction,
) {
  //팝업생성메서드

  showCupertinoDialog(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(dialog),
      actions: action,
    ),
  );
}
