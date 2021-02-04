import 'package:flutter/material.dart';
import 'screens/videos.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner:false,
    routes: {
      '/':(contex)=>VideoPlayer(),
    },
  )
  );
}

