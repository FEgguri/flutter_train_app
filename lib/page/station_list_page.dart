import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    Future<List<dynamic>> loadStations() async {
      String jsonString = await rootBundle.loadString('lib/data/station.json');
      List<dynamic> stations = jsonDecode(jsonString);
      stations.remove(sameStation); //중복된역제거
      return stations;
    }

    // List<String> stations = [
    //   "수서",
    //   "동탄",
    //   "평택지제",
    //   "천안아산",
    //   "오송",
    //   "대전",
    //   "김천구미",
    //   "동대구",
    //   "경주",
    //   "울산",
    //   "부산",
    // ];

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: FutureBuilder<List<dynamic>>(
        // 비동기로 loadStations 함수의 결과를 기다림
        future: loadStations(),
        // builder는 비동기 작업의 현재 상태(snapshot)를 받아서 위젯을 그리는 함수
        builder: (context, asyncSnapshot) {
          // 비동기 작업이 아직 완료되지 않은 상태일 때 (로딩 중)
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            // 로딩 인디케이터(로딩 스피너) 보여주기
            return Center(child: CircularProgressIndicator());
          }

          //데이터 없을때
          if (!asyncSnapshot.hasData) {
            return Center(child: Text('역 정보를 불러올 수 없습니다.'));
          }
          // 비동기 작업이 완료되어 데이터가 있는 상태일 때
          // asyncSnapshot.data는 List<dynamic> 타입
          final stations = asyncSnapshot.data!;

          return ListView.builder(
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
          );
        },
      ),
    );
  }
}
