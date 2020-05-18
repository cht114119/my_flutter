import 'dart:developer';

import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:async';
import '../config/service_url.dart';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import '../config/httpHeaders.dart';
import 'package:shared_preferences/shared_preferences.dart';

Map getSign(Map parameter) {
  var time = new DateTime.now().millisecondsSinceEpoch;
  parameter['time'] = time.toString();

  var subdata = {};

  /// 存储所有key
  List<String> allKeys = [];
  List<String> allValues = [];

  parameter.forEach((key, value) {
    allKeys.add(key);
    //  allKeys.add(key + value);
  });

  /// key排序
  allKeys.sort((obj1, obj2) {
    return obj1.compareTo(obj2);
  });

  /// 添加键值对
  allKeys.forEach((key) {
    subdata[key] = parameter[key];
    allValues.add(subdata[key]);
  });

  /// 数组转string
  // String pairsString = allKeys.join("");
  String pairsString = allValues.join("");

  /// 拼接 sd_secret 是你的秘钥
  String sign = pairsString + 'sd_secret';

  /// hash
  String signString = generateMd5(sign).toUpperCase();
  subdata['sign'] = signString.toString();
  //String signString = md5.convert(utf8.encode(sign)).toString().toUpperCase();  //直接写也可以
  return subdata;
}

/// md5加密
String generateMd5(String data) {
  var content = new Utf8Encoder().convert(data);
  var digest = md5.convert(content);
  // 这里其实就是 digest.toString()
  return hex.encode(digest.bytes);
}

Future loginByAdmin() async {
  try {
    var response;
    Dio dio = new Dio();
    dio.options.headers = httpHeaders;
    var formData = {"password": "111111", "adminUserName": "caohaitao"};
    response =
        await dio.post(servicePath['login_by_admin'], data: getSign(formData));

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print('ERROR:=======>${e}');
  }
}

// 获取频道下的课程列表
Future getArticleList() async {
  try {
    Response response;
    Dio dio = new Dio();
    var formData = {
      "channelId": "1000002",
      "pageNum": '0',
      "pageCount": '10',
    };
    response = await dio.post(servicePath['get_article_list'],
        data: getSign(formData));
    if (response.statusCode == 200) {
      print('getArticleList=====>${response}');
      return response;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print('ERROR:=======>${e}');
  }
}
Future getChannelList() async {
  try {
    Response response;
    Dio dio = new Dio();
    var formData = {
      "contentType": "1",
    };
    response = await dio.post(servicePath['get_channel_list'],
        data: getSign(formData));
    if (response.statusCode == 200) {
      print('getChannelList=====>${response}');
      return response;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print('ERROR:=======>${e}');
  }
}

Future getH5HomePage() async {
  try {
    Response response;
    Dio dio = new Dio();
    var formData = {};
    print('加密后的对象111111111');
  print(getSign(formData));
    response = await dio.post(servicePath['home_page_view'],
        data: getSign(formData));
    if (response.statusCode == 200) {
      print('getH5HomePage=====>${response}');
      return response;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print('ERROR:=======>${e}');
  }
}
