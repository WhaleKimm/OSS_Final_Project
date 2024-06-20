import 'package:flutter/cupertino.dart';

Widget buildSectionTitle(BuildContext context, String title) {
  var colorScheme = CupertinoTheme.of(context);
  return Container(
    color: Color(0xFFdfe2f7), // 제목 배경색 설정
    padding: const EdgeInsets.symmetric(
        vertical: 10.0, horizontal: 16.0), // 내부 여백 설정
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title, // 섹션 제목
          style: TextStyle(
            fontSize: 24, // 글씨 크기 설정
            fontWeight: FontWeight.bold, // 글씨 굵게 설정
            color: Color(0xFF6a75ca), // 글씨 색상 설정
          ),
        ),
        SizedBox(height: 5),
        Container(
          height: 2, // 아래쪽 줄의 높이 설정
          color: Color(0xFF6a75ca), // 아래쪽 줄의 색상 설정
        ),
      ],
    ),
  );
}
