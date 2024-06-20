import 'package:flutter/cupertino.dart'
    show
        CupertinoColors,
        CupertinoIcons,
        CupertinoPageRoute,
        CupertinoScrollbar,
        ScrollController,
        Center,
        EdgeInsets,
        Icon,
        Navigator,
        Padding,
        StatelessWidget,
        Widget,
        Text,
        SizedBox;
import 'package:flutter/widgets.dart'; // ListView와 BuildContext를 가져오기 위해 추가
import 'package:provider/provider.dart';
import 'image_detail_page.dart';
import 'my_app_state.dart';
import 'widgets/cupertino_list_tile.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final ScrollController _favoritesScrollController =
        ScrollController(); // 고유한 ScrollController 추가

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('아직 좋아요 누른 게 없습니다!'),
      );
    }

    return CupertinoScrollbar(
      controller: _favoritesScrollController, // 고유한 ScrollController를 사용
      child: ListView(
        controller: _favoritesScrollController, // 고유한 ScrollController를 사용
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text('당신의 ${appState.favorites.length}개의 좋아요들!'),
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
