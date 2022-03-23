import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'coffe_concept/coffe.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      initialRoute: 'home_page',
      title: 'Material App',
      routes: {
        'home_page': (_) => HomePage(),
      },
    );
  }
}
