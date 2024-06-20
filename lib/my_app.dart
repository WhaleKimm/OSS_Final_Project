import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'my_app_state.dart';
import 'my_home_page.dart';

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
