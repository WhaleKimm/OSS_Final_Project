import 'package:flutter/cupertino.dart';

Widget buildSectionContent(
    BuildContext context, String imagePath, String description) {
  var textStyle = CupertinoTheme.of(context).textTheme.textStyle.copyWith(
        fontFamily: '.SF Pro Text', // iOS 기본 글꼴
        fontSize: 18, // 글씨 크기 설정
        fontWeight: FontWeight.w600, // 글씨 굵기 설정
        color: Color(0xFF6a75ca), // 글씨 색상 설정
      );

  return Container(
    color: Color(0xFFdfe2f7),
    padding: const EdgeInsets.symmetric(
        vertical: 10.0, horizontal: 16.0), // 외부 여백 설정
    child: Container(
      decoration: BoxDecoration(
        color: CupertinoColors.white, // 내용 배경색 설정
        borderRadius: BorderRadius.circular(15.0), // 모서리 둥글게 설정
        boxShadow: [
          BoxShadow(
            color: Color(0xFFdfe2f7), // 제목과 동일한 배경색 설정
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 10.0, horizontal: 16.0), // 내부 여백 설정
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(imagePath,
              height: 150, width: 150, fit: BoxFit.cover), // 섹션 이미지
          SizedBox(width: 20),
          Expanded(
            child: Text(
              description, // 섹션 설명
              style: textStyle, // 설명 텍스트 스타일
              textAlign: TextAlign.left, // 텍스트 정렬
            ),
          ),
        ],
      ),
    ),
  );
}
