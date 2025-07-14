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
  Set<String> selectedSeats = {}; // 선택한 좌석 저장

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('좌석 선택')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
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
          ...List.generate(20, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  seatBox('${index + 1}A'),
                  const SizedBox(width: 4),
                  seatBox('${index + 1}B'),
                  const SizedBox(width: 4),
                  Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(width: 4),
                  seatBox('${index + 1}C'),
                  const SizedBox(width: 4),
                  seatBox('${index + 1}D'),
                ],
              ),
            );
          }),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: () {
              if (selectedSeats.isEmpty) return;

              showCupertinoDialog(
                context: context,
                builder: (_) => CupertinoAlertDialog(
                  title: const Text('예매 확인'),
                  content: const Text('예매를 진행하시겠습니까?'),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('취소'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    CupertinoDialogAction(
                      child: const Text('확인'),
                      onPressed: () {
                        Navigator.pop(context);
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
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(label, style: const TextStyle(fontSize: 18)),
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
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
