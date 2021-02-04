import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vpl/screens/home.dart';
import 'screens/videos.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner:false,
    routes: {
      '/':(contex)=>Home(),
      VideoPlayer.id:(contex)=>VideoPlayer(),
    },
  )
  );
}

