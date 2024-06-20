import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

// MyApp 위젯은 전체 애플리케이션을 감싸고 있습니다.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: CupertinoApp(
        title: 'Self Introduction App',
        theme: CupertinoThemeData(
          primaryColor: CupertinoColors.systemBlue,
          scaffoldBackgroundColor: CupertinoColors.systemBackground,
          textTheme: CupertinoTextThemeData(
            textStyle: TextStyle(
              fontFamily: '.SF Pro Text', // iOS 기본 글꼴
              fontSize: 16,
              color: CupertinoColors.black,
            ),
          ),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

// MyAppState는 애플리케이션의 상태를 관리합니다.
class MyAppState extends ChangeNotifier {
  var favorites = <Map<String, String>>[]; // 즐겨찾기 리스트를 Map 타입으로 변경
  var comments = <int, List<String>>{}; // 댓글 리스트

  // 현재 섹션을 즐겨찾기 목록에 추가하거나 제거하는 메서드
  void toggleFavorite(String imagePath, String title) {
    final favoriteItem = {'imagePath': imagePath, 'title': title};
    if (favorites.contains(favoriteItem)) {
      favorites.remove(favoriteItem);
    } else {
      favorites.add(favoriteItem);
    }
    notifyListeners();
  }

  // 댓글 추가 메서드
  void addComment(int index, String comment) {
    if (comments.containsKey(index)) {
      comments[index]!.add(comment);
    } else {
      comments[index] = [comment];
    }
    notifyListeners();
  }
}

// MyHomePage는 애플리케이션의 메인 페이지입니다.
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
            icon: Icon(CupertinoIcons.circle_grid_3x3_fill),
            label: 'Daily Life',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart),
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
            _buildSectionTitle(context, 'Self Introduction'),
            _buildSectionContent(context, 'assets/profile.png',
                'This is a brief introduction about myself.'),
            _buildSectionTitle(context, 'About'),
            _buildSectionContent(context, 'assets/img_me_1.png',
                'Information about my background and skills.'),
            _buildSectionTitle(context, 'Projects'),
            _buildSectionContent(context, 'assets/project1.png',
                'Details of projects I have worked on.'),
            _buildSectionTitle(context, 'Contact'),
            _buildSectionContent(
                context, 'assets/icon-tistory.png', 'How to contact me.'),
            _buildSectionTitle(context, 'Code'),
            _buildSectionContent(context, 'assets/icon-github.png',
                'Some of my coding examples.'),
          ],
        ),
      ),
    );
  }
}

// FavoritesPage는 즐겨찾기 목록을 표시하는 페이지입니다.
class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final ScrollController _favoritesScrollController =
        ScrollController(); // 고유한 ScrollController 추가

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return CupertinoScrollbar(
      controller: _favoritesScrollController, // 고유한 ScrollController를 사용
      child: ListView(
        controller: _favoritesScrollController, // 고유한 ScrollController를 사용
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text('You have ${appState.favorites.length} favorites:'),
          ),
          for (var favorite in appState.favorites)
            CupertinoListTile(
              leading: Icon(CupertinoIcons.heart_fill,
                  color: CupertinoColors.systemRed),
              title: Text(favorite['title']!), // 제목 표시
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => ImageDetailPage(
                      imagePath: favorite['imagePath']!,
                      title: favorite['title']!,
                      isFavorite: true,
                      onFavoriteToggle: () {
                        appState.toggleFavorite(
                            favorite['imagePath']!, favorite['title']!);
                      },
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

// CupertinoListTile를 직접 구현하는 클래스입니다.
class CupertinoListTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final VoidCallback? onTap;

  const CupertinoListTile({
    required this.leading,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: CupertinoColors.separator,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            leading,
            SizedBox(width: 16),
            Expanded(child: title),
          ],
        ),
      ),
    );
  }
}

// ImageDetailPage 클래스 추가
class ImageDetailPage extends StatefulWidget {
  final String imagePath;
  final String title;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const ImageDetailPage({
    required this.imagePath,
    required this.title,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  _ImageDetailPageState createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.title),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(widget.imagePath, fit: BoxFit.cover),
            SizedBox(height: 20),
            CupertinoButton(
              child: Icon(
                _isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                color: _isFavorite
                    ? CupertinoColors.systemRed
                    : CupertinoColors.black,
              ),
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
                widget.onFavoriteToggle();
              },
            ),
          ],
        ),
      ),
    );
  }
}

// 제목 빌드
Widget _buildSectionTitle(BuildContext context, String title) {
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

// 내용 빌드
Widget _buildSectionContent(
    BuildContext context, String imagePath, String description) {
  var colorScheme = CupertinoTheme.of(context);
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
              style: colorScheme.textTheme.textStyle, // 설명 텍스트 스타일
              textAlign: TextAlign.left, // 텍스트 정렬
            ),
          ),
        ],
      ),
    ),
  );
}

class DailyLifePage extends StatelessWidget {
  final List<Map<String, String>> posts = [
    {
      'imagePath': 'assets/img_me_2.png',
      'title': 'A Day at the Beach',
      'comments': 'Had a great time!',
    },
    {
      'imagePath': 'assets/img_me_3.png',
      'title': 'Hiking Adventure',
      'comments': 'Reached the summit!',
    },
    {
      'imagePath': 'assets/img_me_4.png',
      'title': 'City Lights',
      'comments': 'City vibes!',
    },
    {
      'imagePath': 'assets/img_me_5.png',
      'title': 'Sunset',
      'comments': 'Beautiful sunset!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return CupertinoScrollbar(
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          var post = posts[index];
          var imagePath = post['imagePath']!;
          var title = post['title']!;
          var comments = post['comments']!;
          bool isFavorite = appState.favorites
              .any((favorite) => favorite['imagePath'] == imagePath);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      imagePath,
                      width: double.infinity,
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        color: CupertinoColors.black.withOpacity(0.5),
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 10.0,
                        ),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      child: Icon(
                        isFavorite
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        color: isFavorite
                            ? CupertinoColors.systemRed
                            : CupertinoColors.black,
                      ),
                      onPressed: () {
                        appState.toggleFavorite(imagePath, title);
                      },
                    ),
                    CupertinoButton(
                      child: Icon(CupertinoIcons.chat_bubble),
                      onPressed: () {
                        // 댓글 달기 기능
                        showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            TextEditingController _controller =
                                TextEditingController();
                            return CupertinoAlertDialog(
                              title: Text('Add a Comment'),
                              content: CupertinoTextField(
                                controller: _controller,
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: Text('Add'),
                                  onPressed: () {
                                    appState.addComment(
                                        index, _controller.text);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var comment in appState.comments[index] ?? [])
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Icon(
                                CupertinoIcons.heart_fill,
                                size: 16,
                                color: CupertinoColors.systemGrey,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Today - ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: CupertinoColors.systemGrey,
                                ),
                              ),
                              Text(
                                comment,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: CupertinoColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
