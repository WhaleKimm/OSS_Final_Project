import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';
import 'favorites_page.dart';
import 'daily_life_page.dart';
import 'widgets/section_title.dart'; // 정확한 함수 이름 확인
import 'widgets/section_content.dart'; // 정확한 함수 이름 확인
// import 'my_app_state.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  final ScrollController _scrollController =
      ScrollController(); // 고유한 ScrollController 추가

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Daily Life',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart_solid),
            label: 'Favorites',
          ),
        ],
        backgroundColor: CupertinoColors.systemGrey6, // 메뉴바 배경색 설정
      ),
      tabBuilder: (context, index) {
        Widget page;
        switch (index) {
          case 0:
            page = _buildScrollPage(context); // 스크롤 페이지 추가
            break;
          case 1:
            page = DailyLifePage(); // 새로운 Daily Life 페이지 추가
            break;
          case 2:
            page = FavoritesPage();
            break;
          default:
            throw UnimplementedError('no widget for $selectedIndex');
        }

        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Container(), // 가운데 부분은 비워둠
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0), // 왼쪽에 여백 추가
              child: Text(
                '𝕸𝖞 𝕻𝖔𝖗𝖙𝖋𝖔𝖑𝖎𝖔',
                style: TextStyle(
                  fontSize: 36, // 글씨 크기 설정
                  fontWeight: FontWeight.bold, // 글씨 굵게 설정
                  color: CupertinoColors.black, // 글씨 색상 설정
                ),
              ),
            ),
          ),
          resizeToAvoidBottomInset: true, // 화면 잘림 방지
          child: SafeArea(
            // SafeArea로 내용 감싸기
            child: page,
          ),
        );
      },
    );
  }

  // 스크롤 페이지를 빌드하는 메서드
  Widget _buildScrollPage(BuildContext context) {
    return CupertinoScrollbar(
      controller: _scrollController, // 고유한 ScrollController를 사용
      child: SingleChildScrollView(
        controller: _scrollController, // 고유한 ScrollController를 사용
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20), // 상단에 패딩 추가
            buildSectionTitle(context, 'Self Introduction'),
            buildSectionContent(context, 'assets/profile.png',
                '안녕하세요.\n개발자 오승민입니다.\n만나서 반갑습니다!'),
            buildSectionTitle(context, 'About'),
            buildSectionContent(context, 'assets/img_me_1.png',
                '이름 : 오승민\n생년월일 : 01.07.09\n거주지 : 용인시 수지구\n학교 : 단국대학교\n전공 : 컴퓨터공학'),
            buildSectionTitle(context, 'Hobby'),
            buildSectionContent(context, 'assets/climb1.png',
                '취미는 클라이밍입니다!\n몸을 쓰고 다른 분들과 함께 문제를 푸는 것을 즐깁니다.\nLV5~6에 정착중입니다.'),
            buildSectionTitle(context, 'Projects'),
            buildSectionContent(context, 'assets/project1.png', '행운생성기'),
            buildSectionContent(context, 'assets/project2.png', '자기소개 웹 페이지'),
            buildSectionContent(context, 'assets/project3.png', '비만 관리 프로그램'),
            buildSectionTitle(context, 'Contact & Code'),
            buildSectionContent(context, 'assets/icon-tistory.png',
                'https://whalekimm.tistory.com/'),
            buildSectionContent(context, 'assets/icon-github.png',
                'https://github.com/WhaleKimm'),
          ],
        ),
      ),
    );
  }
}
