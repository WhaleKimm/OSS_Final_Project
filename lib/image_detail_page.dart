import 'package:flutter/cupertino.dart';

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
