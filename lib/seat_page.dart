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
  Set<String> selectedSeats = {}; //선택한 좌석 저장

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('좌석 선택')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          // ABCD 레이블
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

          const SizedBox(height: 20),

          // 좌석 행 20개 생성
          // 여기에 List.generate(20, (index) { ... })
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
                  //행번호 컨테이너
                  Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    child: Text('${index + 1}', style: TextStyle(fontSize: 18)),
                  ),

                  seatBox('${index + 1}C'),
                  SizedBox(width: 4),

                  seatBox('${index + 1}D'),

                  // ...['A', 'B', 'C', 'D'].map((seat) => seatBox()).toList(),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ABCD 레이블을 표시하는 위젯
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
        margin: EdgeInsets.symmetric(horizontal: 4), // 좌석 사이 가로 간격
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
