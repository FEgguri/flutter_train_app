import 'package:flutter/material.dart';

class SeatPage extends StatelessWidget {
  final String departureStation;
  final String arrivalStation;

  SeatPage({
    super.key,
    required this.departureStation,
    required this.arrivalStation,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('좌석 선택')),
      body: Center(child: Text('$departureStation -> $arrivalStation')),
    );
  }
}
