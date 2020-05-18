import 'package:flutter/material.dart';
import './pages/index_page.dart';
void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '十点读书ß',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blue
        ),
        home: IndexPage(),
      ),
    );
  }
}