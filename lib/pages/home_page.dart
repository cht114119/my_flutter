import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../config/httpHeaders.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getH5HomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('十点读书+'),
        ),
        body: FutureBuilder(
          future: getH5HomePage(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              List<Map> swiper =
                  (data['data']['information']['viewSquareBannerList'] as List)
                      .cast();
              List<Map> navigationItem = (data['data']['information']
                      ['viewSquareQuickStartList'] as List)
                  .cast();
              String commonAdvert = (data['data']['information']['adverts']['commonAdvert']['imgUrl'] as String).toString();
              return Column(
                children: <Widget>[
                  SwiperDiy(swiperDateList: swiper),
                  TopNavigator(navigatotList: navigationItem),
                  AdBanner(adImgUrl:commonAdvert)
                ],
              );
            } else {
              return Center(
                child: Text('加载中'),
              );
            }
          },
        ));
  }
}

// 首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDateList;
  const SwiperDiy({Key key, this.swiperDateList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            '${swiperDateList[index]['imgUrl']}',
            fit: BoxFit.fill,
          );
        },
        itemCount: swiperDateList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

// 导航栏组件
class TopNavigator extends StatelessWidget {
  final List navigatotList;
  const TopNavigator({Key key, this.navigatotList}) : super(key: key);

  Widget _gridViewItemUi(BuildContext context, item) {
    if (this.navigatotList.length > 8) {
      this.navigatotList.removeRange(8, this.navigatotList.length);
    }
    return InkWell(
      onTap: () {
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['icon'],
            width: ScreenUtil().setWidth(95),
          ),
          Text(item['name'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 4,
        padding: EdgeInsets.all(5.0),
        children: navigatotList.map((item) {
          return _gridViewItemUi(context, item);
        }).toList(),
      ),
    );
  }
}

// 广告组件
class AdBanner extends StatelessWidget {

  final String adImgUrl;
  const AdBanner({Key key,this.adImgUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adImgUrl,width: ScreenUtil().setWidth(700),),
    );
  }
}




// 13集 首页广告banner
