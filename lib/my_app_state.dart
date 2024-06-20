import 'package:flutter/cupertino.dart';

class MyAppState extends ChangeNotifier {
  var favorites = <Map<String, String>>[]; // 즐겨찾기 리스트를 Map 타입으로 변경
  var comments = <int, List<String>>{}; // 댓글 리스트

  // 현재 섹션을 즐겨찾기 목록에 추가하거나 제거하는 메서드
  void toggleFavorite(String imagePath, String title) {
    final favoriteItem = {'imagePath': imagePath, 'title': title};
    bool exists = favorites.any((favorite) =>
        favorite['imagePath'] == imagePath && favorite['title'] == title);

    if (exists) {
      favorites.removeWhere((favorite) =>
          favorite['imagePath'] == imagePath && favorite['title'] == title);
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
