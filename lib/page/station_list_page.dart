import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_train_app/utils/show_dialog.dart';

class StationListPage extends StatelessWidget {
  final String title; //appbar에 표시할 타이틀 이름
  final String? sameStation;

  const StationListPage({
    super.key,
    required this.title,
    required this.sameStation,
  });

  @override
  Widget build(BuildContext context) {
    List<String> stations = [
      "수서",
      "동탄",
      "평택지제",
      "천안아산",
      "오송",
      "대전",
      "김천구미",
      "동대구",
      "경주",
      "울산",
      "부산",
    ];
    stations.remove(sameStation); //중복된역제거
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (sameStation != stations[index]) {
                Navigator.pop(context, stations[index]);
              } else {
                dialog(context, '오류', '중복된 역입니다. 다른 역을 선택해주세요', [
                  CupertinoDialogAction(
                    child: Text('확인'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ]);
                // showCupertinoDialog(
                //   //중복된 역이 혹시 나왔을때 검증
                //   context: context,
                //   builder: (_) => CupertinoAlertDialog(
                //     title: Text('오류'),
                //     content: Text('중복된 역입니다. 다른 역을 선택해주세요'),
                //     actions: [
                //       CupertinoDialogAction(
                //         child: Text('확인'),
                //         onPressed: () => Navigator.pop(context),
                //       ),
                //     ],
                //   ),
                // );
              }
              // 선택한 역 반환
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                stations[index],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
