import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  final String title; //appbar에 표시할 타이틀 이름

  StationListPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    List<String> stations = ['범골', '회룡', '경기도청북부청사', '의정부역', '의정부시청'];
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pop(context, stations[index]); // 선택한 역 반환
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
