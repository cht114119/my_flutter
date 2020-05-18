import 'package:flutter/material.dart';//谷歌风格
import 'package:flutter/cupertino.dart'; //IOS风格
import './home_page.dart';
import './category_page.dart';
import './cart_page.dart';
import './member_page.dart';
import 'package:flutter_screenutil/screenutil.dart';


class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  final List<BottomNavigationBarItem> bottomTabs=[
      BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title:Text('首页')
      ),
      BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title:Text('分类')
      ),
      BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title:Text('购物车')
      ),
      BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title:Text('会员')
      ),
  ];
  
  final List tabBodies=[
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];
  
  int currentIndex = 0;
  var currentPage ;
  
  @override
  void initState() {
    // TODO: implement initState
    currentPage = tabBodies[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index ){
          setState(() {
            currentIndex = index;
            currentPage=tabBodies[currentIndex];
          });
        },
      ),
      body: currentPage,
    );
  }
}