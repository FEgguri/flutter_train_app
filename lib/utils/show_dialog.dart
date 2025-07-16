import 'package:flutter/cupertino.dart';

void dialog(
  //파라미터
  BuildContext context, //위젯 위치
  String title, //제목
  String dialog, //메세지
  List<Widget> action, //버튼들
) {
  showCupertinoDialog(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(dialog),
      actions: action,
    ),
  );
}
