import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_train_app/seat_page.dart';
import 'package:flutter_train_app/station_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? departureStation; //출발역
  String? arrivalStation; //도착역
  Set<String> bookedSeats = {}; //예약된좌석
  @override
  Widget build(BuildContext context) {
    dialog(String dialog) {
      //팝업생성메서드

      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: Text('오류'),
          content: Text(dialog),
          actions: [
            CupertinoDialogAction(
              //확인버튼을 누르면 이전화면으로
              child: Text('확인'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('기차 예매'), centerTitle: true),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  height: 200,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            // 사용자가 이 위젯을 탭했을 때 실행되는 비동기 함수 시작
                            final result = await Navigator.push(
                              // Navigator를 통해 새로운 페이지로 이동하면서, 해당 페이지에서 결과를 받아올 수 있음
                              context, // await는 Navigator.push가 새 페이지에서 pop 될 때까지 기다림
                              // 즉, StationListPage에서 Navigator.pop(context, 선택한역) 했을 때 값을 받아오는 부분
                              MaterialPageRoute(
                                // MaterialPageRoute는 새 페이지를 애니메이션과 함께 보여주도록 하는 라우트
                                builder: (_) => StationListPage(
                                  title: '출발역', // 새 페이지에 전달할 매개변수들
                                  sameStation: arrivalStation,
                                ),
                              ),
                            );

                            if (result != null) {
                              // 만약 결과가 null이 아니라면(즉, 사용자가 역을 선택했다면)
                              setState(() {
                                // 상태를 갱신해서 UI를 다시 그림
                                departureStation =
                                    result; // 선택된 역을 departureStation에 저장
                              });
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '출발역',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                departureStation ?? '선택',
                                style: TextStyle(fontSize: 40),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //새로선
                      Container(width: 2, height: 50, color: Colors.grey[400]),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            //??
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => StationListPage(
                                  title: '도착역',
                                  sameStation: departureStation,
                                ),
                              ),
                            );
                            if (result != null) {
                              setState(() {
                                arrivalStation = result;
                              });
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '도착역',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                arrivalStation ?? '선택',
                                style: TextStyle(fontSize: 40),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      // 출발역 도착역이 모두 선택됐을때 이동
                      if (departureStation != null && arrivalStation != null) {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SeatPage(
                              departureStation: departureStation!,
                              arrivalStation: arrivalStation!,
                              bookedSeats: bookedSeats,
                            ),
                          ),
                        );
                        if (result != null) {
                          setState(() {
                            bookedSeats.addAll(result);
                          });
                        }
                      } else if (departureStation == null &&
                          arrivalStation != null) {
                        dialog('출발역을 선택해주세요');
                      } else if (departureStation != null &&
                          arrivalStation == null) {
                        dialog('도착역을 선택해주세요');
                      } else {
                        dialog('출발역,도착역을 선택해주세요');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      '좌석 선택',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
