import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'my_app_state.dart';

class DailyLifePage extends StatelessWidget {
  final List<Map<String, String>> posts = [
    {
      'imagePath': 'assets/img_me_2.png',
      'title': '강릉',
    },
    {
      'imagePath': 'assets/img_me_3.png',
      'title': '스티커 사진',
    },
    {
      'imagePath': 'assets/img_me_4.png',
      'title': '근육',
    },
    {
      'imagePath': 'assets/img_me_5.png',
      'title': '여자친구와',
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
