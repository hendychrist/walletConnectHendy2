import 'package:flutter/material.dart';
import 'package:testing_app/screen/bottom_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
            builder:   (BuildContext context, Widget? child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                    child: child ?? const SizedBox(),
                  );
                }, 
            home: BottomBarScreen(),
          );
        
  }
}
