import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LocalStorage{
  @required String key;
  LocalStorage();
  void savePaths(List<String> list)async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
     sharedPreferences.setStringList(key,list);
  }
  void getPaths(List<String> list)async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    list = sharedPreferences.getStringList(key) ?? [];
  }
}