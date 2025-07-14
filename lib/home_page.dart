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
  String? departureStation;
  String? arrivalStation;
  Set<String> bookedSeats = {};
  @override
  Widget build(BuildContext context) {
    dialog(String dialog) {
      //팝업
      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: Text('오류'),
          content: Text(dialog),
          actions: [
            CupertinoDialogAction(
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
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => StationListPage(
                                  title: '출발역',
                                  sameStation: arrivalStation,
                                ),
                              ),
                            );
                            if (result != null) {
                              setState(() {
                                departureStation = result;
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
