import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeatPage extends StatefulWidget {
  final String departureStation;
  final String arrivalStation;

  const SeatPage({
    super.key,
    required this.departureStation,
    required this.arrivalStation,
  });

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  Set<String> selectedSeats = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('좌석 선택'), centerTitle: true),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20),
        children: [
          Row(
            //출발역 도착역 안내
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.departureStation,
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.arrow_circle_right_outlined,
                size: 30,
                color: Colors.purple,
              ),
              SizedBox(width: 8),
              Text(
                widget.arrivalStation,
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 선택됨
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(width: 4),
                  Text('선택됨'),
                ],
              ),
              SizedBox(width: 20),
              // 선택안됨
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(width: 4),
                  Text('선택안됨'),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              'A',
              'B',
              '',
              'C',
              'D',
            ].map((e) => seatLabel(e)).toList(),
          ),
          SizedBox(height: 20),
          ...List.generate(20, (index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  seatBox('${index + 1}A'),
                  SizedBox(width: 4),
                  seatBox('${index + 1}B'),
                  SizedBox(width: 4),
                  Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    child: Text('${index + 1}', style: TextStyle(fontSize: 18)),
                  ),
                  SizedBox(width: 4),
                  seatBox('${index + 1}C'),
                  SizedBox(width: 4),
                  seatBox('${index + 1}D'),
                ],
              ),
            );
          }),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: () {
              if (selectedSeats.isEmpty) return;

              showCupertinoDialog(
                context: context,
                builder: (_) => CupertinoAlertDialog(
                  title: Text('예매 확인'),
                  content: Text(
                    '예매를 진행하시겠습니까?\n선택한 좌석: ${selectedSeats.join(', ')}',
                  ),
                  actions: [
                    CupertinoDialogAction(
                      child: Text('취소'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    CupertinoDialogAction(
                      child: Text('확인'),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              '예매 하기',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget seatLabel(String label) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: Text(label, style: TextStyle(fontSize: 18)),
    );
  }

  Widget seatBox(String seatId) {
    final isSelected = selectedSeats.contains(seatId);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedSeats.remove(seatId);
          } else {
            selectedSeats.add(seatId);
          }
        });
      },
      child: Container(
        width: 50,
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
